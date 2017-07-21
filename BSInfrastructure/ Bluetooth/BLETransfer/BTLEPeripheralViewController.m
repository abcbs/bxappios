
#import "BTLEPeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "TransferService.h"


@interface BTLEPeripheralViewController () <CBPeripheralManagerDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView       *textView;

@property (strong, nonatomic) IBOutlet UISwitch         *advertisingSwitch;


@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;
@property (strong, nonatomic) CBMutableService *transferService ;
@property (strong, nonatomic) NSData                    *dataToSend;
@property (nonatomic, readwrite) NSInteger              sendDataIndex;

@end


@implementation BTLEPeripheralViewController



#pragma mark - View Lifecycle



- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    self.textView.delegate=self;
     _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.peripheralManager stopAdvertising];
    
    [super viewWillDisappear:animated];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // Opt out from any other state
    //不是就绪状态则返回
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    
    // We're in CBPeripheralManagerStatePoweredOn state...
    NSLog(@"self.peripheralManager powered on.");
    
    // ... so build our service.
    // 构建服务
    // Start with the CBMutableCharacteristic
    /** 1.服务特性信息
     *       方法给特征创建了一个UUID对象，然后我用这个UUID对象创建了一个特征。
     *   注意：我给初始化特征方法的第三个参数赋值nil，这是，我告诉CoreBluetooth，
     *   我将稍后添加一个特征的值。当你想要创建一个动态的数据,一般都这么做。如果你已经有了一直静态的值要，你可以将它赋值在这儿。
     */
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                                                     properties:CBCharacteristicPropertyNotify
                                                                          value:nil//表示数据应需而发
                                                                    permissions:CBAttributePermissionsReadable];
    
    // Then the service
    //2.创建周边服务
    self.transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
         primary:YES];
    
    // Add the characteristic to the service
    /**3.特征值添加到服务中
     *   一个周边可以有多个服务，一个服务可以有多个特征值
     */
    self.transferService.characteristics = @[self.transferCharacteristic];
    
    // And add it to the peripheral manager
    /**4.服务添加到周边管理者（Peripheral Manager）是用于发布服务
     *
     *      一旦完成这个，周边管理者会通知他的代理方法
     *  -peripheralManager:didAddService:error:。
     *  现在，如果没有Error，你可以开始广播服务了：
     *
     */
    [self.peripheralManager addService:self.transferService];
}

/**Added LiuJQ 20150813
 *   5. 可以发布消息，周边管理者开始广播服务
 *      当执行addService方法后执行如下回调，当你发布一个服务和任何一个相关特征的描述到GATI数据库的时候执行
 *
 *      方法peripheralManagerDidUpdateState把服务添加到周边管理者是用于发布服务。
 *   一旦完成这个，周边管理者会通知他的代理方法-peripheralManager:didAddService:error:。
 *   现在，如果没有Error，你可以开始广播服务了：
 */
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

/**Added LiuJQ 20150813
 *  6. 可以发布消息，周边管理者开始广播服务,
 *  开始向外广播数据  当startAdvertising被执行的时候调用这个代理方法
 *
 *  当周边管理者开始广播服务，他的代理接收-peripheralManagerDidStartAdvertising:error: 消息，并且当中央预定了这个服务，
 *  他的代理接收 -peripheralManager:central:didSubscribeToCharacteristic:消息，这儿是你给中央生成动态数据的地方。
 *  现在，要发送数据到中央，你需要准备一些数据，然后发送updateValue:forCharacteristic:onSubscribedCentrals: 到周边。
 *
 */
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    BSLog(@"可以发布消息，周边管理者开始广播服务,等待中心订阅");
    
}

/** Catch when someone subscribes to our characteristic, then start sending them data
 *  This method is invoked when a central removes notifications/indications from
 *  发送消息的场景
 *      central订阅了characteristic的值，当更新值的时候,peripheral会调用
 *          [updateValue: forCharacteristic: onSubscribedCentrals:(NSArray*)centrals]
 *  去为数组里面的centrals更新对应characteristic的值，在更新过后peripheral为每一个central走一遍改代理方法
 */
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


/** This callback comes in when the PeripheralManager is ready to send the next chunk of data.
 *  This is to ensure that packets will arrive in the order they are sent
 *
 *      peripheral再次准备好发送Characteristic值的更新时候调用
 *  当updateValue: forCharacteristic:onSubscribedCentrals:方法调用因为底层用于传输
 *  Characteristic值更新的队列满了而更新失败的时候，实现这个委托再次发送改值
 */
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    // Start sending again
    [self sendData];
}

/** Recognise when the central unsubscribes
 *  当central取消订阅characteristic这个特征的值后调用方法。使用这个方法提示停止为这个central发送更新
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"Central unsubscribed from characteristic");
}

/**
 *peripheral提供信息，dict包含了应用程序关闭是系统保存的peripheral的信息，用dic去恢复peripheral
 *app状态的保存或者恢复，这是第一个被调用的方法当APP进入后台去完成一些蓝牙有关的工作设置，使用这个方法同步app状态通过蓝牙系统
 *dic里面有两对key值分别对应服务（数组）和数据（数组）
 */
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
            sendingEOM = NO;
            
            BSLog(@"Sent: EOM");
        }
        
        // It didn't send, so we'll exit and wait for peripheralManagerIsReadyToUpdateSubscribers to call sendData again
        return;
    }
    
    // We're not sending an EOM, so we're sending data
    
    // Is there any left to send?
    
    if (self.sendDataIndex >= self.dataToSend.length) {
        
        // No data left.  Do nothing
        return;
    }
    
    // There's data left, so send until the callback fails, or we're done.
    
    BOOL didSend = YES;
    
    while (didSend) {
        
        // Make the next chunk
        
        // Work out how big it should be
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // Can't be longer than 20 bytes
        if (amountToSend > NOTIFY_MTU) amountToSend = NOTIFY_MTU;
        
        // Copy out the data we want
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        // Send it
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // If it didn't work, drop out and wait for the callback
        if (!didSend) {
            return;
        }
        
        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", stringFromData);
        
        // It did send, so update our index
        self.sendDataIndex += amountToSend;
        
        // Was it the last one?
        if (self.sendDataIndex >= self.dataToSend.length) {
            
            // It was - send an EOM
            
            // Set this so if the send fails, we'll send it next time
            sendingEOM = YES;
            
            // Send it
            BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                // It sent, we're all done
                sendingEOM = NO;
                
                BSLog(@"Sent: EOM");
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
    //[textView resignFirstResponder];
}


/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    //[self.tintColor]
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
