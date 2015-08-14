//
//  ESSIssueViewController.m
//  KTAPP
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ESSIssueViewController.h"
#import "BSIFTTHeader.h"
#import "TransferService.h"

@interface ESSIssueViewController ()<CBPeripheralManagerDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView       *textView;

@property (strong, nonatomic) IBOutlet UISwitch         *advertisingSwitch;

//周边管理
@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;

@property (strong, nonatomic) CBMutableService *transferService;
//特征值
/**
 *      在中央这边，CBService 类代表服务，CBCharacteristic 类代表特征。
 *  在周边这边，CBMutableService 类代表服务，CBMutableCharacteristic 类代表特征。
 */
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;

//发送的数据
@property (strong, nonatomic) NSData                    *dataToSend;

@property (nonatomic, readwrite) NSInteger              sendDataIndex;

@end

@implementation ESSIssueViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    self.textView.delegate=self;
    [super viewDidLoad];
     _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
     [self.peripheralManager stopAdvertising];
    
    [super viewWillDisappear:animated];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }

    NSLog(@"self.peripheralManager powered on.");
 
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                                                     properties:CBCharacteristicPropertyNotify
                                                                          value:nil//表示数据应需而发
                                                                    permissions:CBAttributePermissionsReadable];
    
    self.transferService= [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                                                       primary:YES];
    self.transferService.characteristics = @[self.transferCharacteristic];
    
    [self.peripheralManager addService:self.transferService];
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
        // Starts advertising the service
        [self.peripheralManager startAdvertising:
         @{ CBAdvertisementDataLocalNameKey :
                @"ICServer", CBAdvertisementDataServiceUUIDsKey :
                @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    BSLog(@"可以发布消息，周边管理者开始广播服务,等待中心订阅");
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"Central subscribed to characteristic");
    
    // Get the data
    self.dataToSend = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    
    // Reset the index
    self.sendDataIndex = 0;
    
    // Start sending
    [self sendData];
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    [self sendData];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"Central unsubscribed from characteristic");
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary *)dict{
    BSLog(@"willRestoreState");
}

//当peripheral接受到一个读ATT读请求，数据在CBATTRequest
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    
}

//当peripheral接受到一个写请求的时候调用，参数有一个数组的CBATTRequest对象request
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    
}

/** Sends the next amount of data to the connected central
 */
- (void)sendData
{
    // First up, check if we're meant to be sending an EOM
    static BOOL sendingEOM = NO;
    
    if (sendingEOM) {
        // send it
        BOOL didSend = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // Did it send?
        if (didSend) {
            // It did, so mark it as sent
            // 发送结束
            sendingEOM = NO;
        }
        //如果发送失败，则系统调用下面方法在发射一次
        //peripheralManagerIsReadyToUpdateSubscribers to call sendData again
        return;
    }
    
    // We're not sending an EOM, so we're sending data
    // Is there any left to send?
    // 发送得不是结束标记，需要发送剩余的数据
    
    if (self.sendDataIndex >= self.dataToSend.length) {
        //发送数据结束，直接返回
        return;
    }
    
    // There's data left, so send until the callback fails, or we're done.
    // 发送数据，直到回调失败或者正常终止
    BOOL didSend = YES;
    
    while (didSend) {
        // Make the next chunk
        // Work out how big it should be
        // 计算要发送数据的大小
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // Can't be longer than 20 bytes
        // 每次发送20个字节
        if (amountToSend > NOTIFY_MTU) amountToSend = NOTIFY_MTU;
        
        // Copy out the data we want
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        // Send it
        // 发送数据块 datachunk
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // If it didn't work, drop out and wait for the callback
        //如果没有发送完成,退出,等待回调
        if (!didSend) {
            return;
        }
        
        //NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        //NSLog(@"Sent: %@", stringFromData);
        
        // It did send, so update our index
        self.sendDataIndex += amountToSend;
        
        // Was it the last one?
        //发送结束判断
        if (self.sendDataIndex >= self.dataToSend.length) {
             // It was - send an EOM
             // Set this so if the send fails, we'll send it next time
            sendingEOM = YES;
            // Send it
            BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                sendingEOM = NO;
            }
            return;
        }
    }
}
#pragma mark - TextView Methods

/** This is called when a change happens, so we know to stop advertising
 */
- (void)textViewDidChange:(UITextView *)textView
{
    // If we're already advertising, stop
    if (self.advertisingSwitch.on) {
        [self.advertisingSwitch setOn:NO];
        [self.peripheralManager stopAdvertising];
    }
    [textView resignFirstResponder];
}


/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


/** Finishes the editing */
- (void)dismissKeyboard
{
    [self.textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Switch Methods
/** Start advertising
 */
- (IBAction)switchChanged:(id)sender
{
    if (self.advertisingSwitch.on) {
        // All we advertise is our service's UUID
        [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
    }
    
    else {
        [self.peripheralManager stopAdvertising];
    }
}



@end
