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
//#import ""
static const char *const kBeaconsIssuseQueueName = "kESSBeaconIssuseBeaconsOperationQueueName";

@interface ESSBeaconIssue () <CBPeripheralManagerDelegate>{
    //定义分发队列
    dispatch_queue_t _beaconIssuseQueue;
    ESSBeaconInfo *beaconInfo;
    ESSBeaconID *essBeaconID;
    NSNumber *rssi;
    NSString *identifier;
    NSDictionary *advertisingData;
    NSDictionary *essstoneAdvertising;
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
        identifier=@"identifier";
    }
    
    return self;
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    BSLog(@"周边信标准备完成，准备开启服务");
    [self setupService];
    
}

- (void)setupService {
   dispatch_async(_beaconIssuseQueue, ^{
    // Creates the characteristic UUID
    //创建UUID特征值
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kESSddystoneCharacteristicUUID];
    
    //特征值
    NSString *strUUID =identifier;
    NSData *dataUUID = [strUUID dataUsingEncoding:NSUTF8StringEncoding];
    // Creates the characteristic
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:
                                 characteristicUUID properties:CBCharacteristicPropertyRead
                                     value:dataUUID permissions:CBAttributePermissionsReadable];
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kESSEddystoneServiceID];
    self.transferService = [[CBMutableService alloc] initWithType:serviceUUID
                                                        primary:YES];
    [self.transferService setCharacteristics:
        @[self.transferCharacteristic]];
    
       
    [self.peripheralManager addService:self.transferService];
   
    if (advertisingData==nil) {
        //frameType类型
        NSString *stringInt = [NSString stringWithFormat:@"%d",
                              kEddystoneUIDFrameTypeID];
        
        NSData *frameType=
        [stringInt dataUsingEncoding:NSUTF8StringEncoding];
        
        //frameType=[NSData alloc]i
        
        CBUUID *eddystoneServiceUUID = [ESSBeaconInfo eddystoneServiceID];
        
        //ESSStoneBeacon广播数据
        ESSEddystoneUIDFrameFields uidFrame;
        uidFrame.frameType=0;
        uidFrame.txPower=-50;
        //广告是kEddystoneServiceID
       
        //6个字节
        NSString *serviceInstance= kEddystoneServiceInstance;
        serviceInstance=[kEddystoneNamespace stringByAppendingString:serviceInstance];

        memcpy(uidFrame.zipBeaconID, [serviceInstance
                        UTF8String], sizeof(uidFrame.zipBeaconID)+1);
        //广告数据
        NSData *data= [[NSData alloc]initWithBytes:&uidFrame length:sizeof(ESSEddystoneUIDFrameFields)];

       essstoneAdvertising=@{kESSEddystoneServiceID:frameType,
               eddystoneServiceUUID:data
        };
     
        advertisingData =@{
            CBAdvertisementDataServiceUUIDsKey :
             @[[CBUUID UUIDWithString:kESSEddystoneServiceID]],
                CBAdvertisementDataServiceDataKey:essstoneAdvertising
         };
       
        [self.peripheralManager startAdvertising:advertisingData];
    }
    BSLog(@"周边信标服务初始化完成");
   });
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"中心可以订阅特征值...");
    // Get the data
    if ([_delegate respondsToSelector:@selector(sendingData:)]) {
       self.dataToSend=[_delegate sendingData:self];
    }
    // Reset the index
    self.sendDataIndex = 0;

    [self sendData];
    
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    [self sendData];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
       [self sendData];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    BSLog(@"可以发布消息，周边管理者开始广播服务,等待中心订阅");
    if (error==nil) {
        BSLog(@"中心可以订阅特征值...");
        // Get the data
        if ([_delegate respondsToSelector:@selector(sendingData:)]) {
            self.dataToSend=[_delegate sendingData:self];
        }
        // Reset the index
        self.sendDataIndex = 0;
        [self sendData];
    }
    
}

- (BOOL)fixBeaconData{
    return [self sendESSBeaconData:kEddystoneServiceInstance];
}

- (BOOL)didBeaconData:(NSObject *)value{
    NSData *data=nil;
    if ([value isKindOfClass:[NSString class]]) {
        data=[self sendESSBeaconData:(NSString *)value];
 
    }else if ([value isKindOfClass:[NSData class]]){
        data=(NSData *)value;
    }
    return [self.peripheralManager updateValue:data forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
}

-(NSData *)sendESSBeaconData:(NSString *)value{
    //ESSStoneBeacon广播数据
    ESSEddystoneUIDFrameFields uidFrame;
    uidFrame.frameType=0;
    uidFrame.txPower=-50;
    //广告是kEddystoneServiceID
     //6个字节
    NSString *serviceInstance=[kEddystoneNamespace stringByAppendingString:value];
    
    memcpy(uidFrame.zipBeaconID, [serviceInstance
                                  UTF8String], sizeof(uidFrame.zipBeaconID)+1);
    //广告数据
    return [[NSData alloc]initWithBytes:&uidFrame length:sizeof(ESSEddystoneUIDFrameFields)];

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
        
        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"发送的广告数据为:\t %@", stringFromData);
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
