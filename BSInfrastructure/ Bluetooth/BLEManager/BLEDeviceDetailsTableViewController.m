//
//  BLEInfoTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BLEDeviceDetailsTableViewController.h"

@implementation BLEDeviceDetailsTableViewController

//记得把之前的centrlMgr传过来，记得要重新设置delegate：
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_centralMgr setDelegate:self];
    if (_discoveredPeripheral)
    {
        //下面中央设备向周边设备发起连接。
        [_centralMgr connectPeripheral:_discoveredPeripheral options:nil];
    }
    _arrayServices = [[NSMutableArray alloc] init];
    _characteristicNum = 0;
}

//可以实现下面的函数，如果连接失败，就会得到回调：
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didFailToConnectPeripheral : %@", error.localizedDescription);
}

//必须实现didConnectPeripheral，只要连接成功，就能回调到该函数，开始获取服务。
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [self.arrayServices removeAllObjects];
    
    [_discoveredPeripheral setDelegate:self];
    //discoverServices就是查找该周边设备的服务
    [_discoveredPeripheral discoverServices:nil];
}

//3.获取服务：
//当找到了服务之后，就能进入didDiscoverServices的回调。我们把全部服务都保存起来。
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        NSLog(@"didDiscoverServices : %@", [error localizedDescription]);
        //        [self cleanup];
        return;
    }
    
    for (CBService *s in peripheral.services)
    {
        NSLog(@"Service found with UUID : %@", s.UUID);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{SECTION_NAME:s.UUID.description}];
        [self.arrayServices addObject:dic];
        [s.peripheral discoverCharacteristics:nil forService:s];
    }
}

//4. 获取特性
//我们通过discoverCharacteristics来获取每个服务下的特性，通过下面的回调来获取。
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"didDiscoverCharacteristicsForService error : %@", [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *c in service.characteristics)
    {
        self.characteristicNum++;
        [peripheral readValueForCharacteristic:c];
    }
}

//5. 获取特性值
//readValueForCharacteristic可以读取特性的值。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    self.characteristicNum--;
    if (self.characteristicNum == 0)
    {
        [self.tableView reloadData];
    }
    
    if (error)
    {
        NSLog(@"didUpdateValueForCharacteristic error : %@", error.localizedDescription);
        return;
    }
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    if ([stringFromData isEqualToString:@"EOM"])
    {
        NSLog(@"the characteristic text is END");
        //        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        //        [self.centralMgr cancelPeripheralConnection:peripheral];
    }
    
    for (NSMutableDictionary *dic in self.arrayServices)
    {
        NSString *service = [dic valueForKey:SECTION_NAME];
        if ([service isEqual:characteristic.service.UUID.description])
        {
            NSLog(@"characteristic.description : %@", characteristic.UUID.description);
            [dic setValue:characteristic.value forKey:characteristic.UUID.description];
        }
    }
}

@end
