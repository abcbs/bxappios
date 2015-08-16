//
//  ESSBeaconIssue.m
//  KTAPP
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//
#import <CoreBluetooth/CoreBluetooth.h>
#import "ESSBeaconIssue.h"
#import "ESSEddystone.h"
#import "BSIFTTHeader.h"

static const char *const kBeaconsIssuseQueueName = "kESSBeaconIssuseBeaconsOperationQueueName";

@interface ESSBeaconIssue () <CBPeripheralManagerDelegate>{
    //定义分发队列
    dispatch_queue_t _beaconIssuseQueue;
    ESSBeaconInfo *beaconInfo;
    ESSBeaconID *essBeaconID;
    NSNumber *rssi;
}


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
//发送的数据索引
@property (nonatomic, readwrite) NSInteger              sendDataIndex;

@end

@implementation ESSBeaconIssue

- (instancetype)init {
    if ((self = [super init]) != nil) {
        //创建一个自定义的串行队列,队列的属性被保留供将来使用，应该为NULL
        _beaconIssuseQueue =
        dispatch_queue_create(kBeaconsIssuseQueueName, NULL);
         _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:_beaconIssuseQueue];
    }
    
    return self;
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    BSLog(@"self.peripheralManager powered on.");
    [self setupService];
    
}

- (void)setupService {
   dispatch_async(_beaconIssuseQueue, ^{
    // Creates the characteristic UUID
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kESSddystoneCharacteristicUUID];
    // Creates the characteristic
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:
                                 characteristicUUID properties:CBCharacteristicPropertyNotify
                                                                        value:nil permissions:CBAttributePermissionsReadable];
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kESSEddystoneServiceID];
    self.transferService = [[CBMutableService alloc] initWithType:serviceUUID
                                                        primary:YES];
    [self.transferService setCharacteristics:
        @[self.transferCharacteristic]];
    [self.peripheralManager addService:self.transferService];
   });
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"Central subscribed to characteristic");
    // Get the data
    if ([_delegate respondsToSelector:@selector(sendingData:)]) {
        self.dataToSend=[_delegate sendingData:self];
    }
    // Reset the index
    self.sendDataIndex = 0;

    //实例化ESSBeaconID
    NSData *beaconID= [kESSEddystoneServiceID dataUsingEncoding:NSUTF8StringEncoding]; ;
     essBeaconID= [[ESSBeaconID alloc] initWithType:kESSBeaconTypeEddystone
        beaconID:beaconID];

    rssi= [NSNumber numberWithInt:RSSI];
    beaconInfo=[[ESSBeaconInfo alloc] initWithBeaconID:essBeaconID
                                    txPower:@(ADVERTISE_TX_POWER_MEDIUM)
                                       RSSI:rssi
                                  telemetry:self.dataToSend];
    [self sendData];
    
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    [self sendData];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
       [self startIssue];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    BSLog(@"可以发布消息，周边管理者开始广播服务,等待中心订阅");
    
}

- (BOOL)fixBeaconData{
    //beaconInfo
    NSData *data=[@"EOM" dataUsingEncoding:NSUTF8StringEncoding];
    return [self.peripheralManager updateValue:data forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
}

- (BOOL)didBeaconData:(NSData *)value{
    beaconInfo=[[ESSBeaconInfo alloc] initWithBeaconID:essBeaconID
             txPower:@(ADVERTISE_TX_POWER_MEDIUM)
             RSSI:rssi
             telemetry:self.dataToSend];
    
    return [self.peripheralManager updateValue:self.dataToSend forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
}

/** Sends the next amount of data to the connected central
 */
- (void)sendData
{
    // First up, check if we're meant to be sending an EOM
    static BOOL sendingEOM = NO;
    
    if (sendingEOM) {
        // send it
        BOOL didSend =[self fixBeaconData];
        
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
        if (amountToSend > notify_mtu) amountToSend = notify_mtu;
        
        // Copy out the data we want
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        // Send it
        // 发送数据块 datachunk
        didSend =[self didBeaconData:chunk];
        
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
            //BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            BOOL eomSent =[self fixBeaconData];
            if (eomSent) {
                sendingEOM = NO;
            }
            return;
        }
    }
}

- (void)startIssue{
    // Starts advertising the service
    [self.peripheralManager startAdvertising:
     @{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:kESSEddystoneServiceID]] }];
}


- (void)stopIssue{
    [self.peripheralManager stopAdvertising];
}

@end
