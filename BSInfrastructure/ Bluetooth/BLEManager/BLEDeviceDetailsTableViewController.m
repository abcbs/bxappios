//
//  BLEInfoTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BLEDeviceDetailsTableViewController.h"
#import "BSIFTTHeader.h"

@interface BLEDeviceDetailsTableViewController ()
{
    UILabel *header;
    //根据服务获取特征值的字典
    NSMutableDictionary *characteristicDic;
    NSMutableDictionary *characteristicValueDic;
}
@end

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

/**
 *章节的标题,自定义表格头信息,设置每个section显示的Title
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_arrayServices.count==0) {
        return @"暂无服务";
    }
    NSDictionary *dic= [_arrayServices objectAtIndex:section];
    NSArray *values = [dic allValues];
    return [values objectAtIndex:0];
}

-(void)handleTableHeander:(NSString *)name{
    if (header==nil) {
        header=[[UILabel alloc]init];
        header.size=BSSizeMake(SCREEN_WIDTH*.2, SCREEN_HEIGHT*.1);
        self.tableView.tableHeaderView = header;
    }

    header.text=name;

}

/**
 *TableView 表的章节数量,指定有多少个分区(Section)
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_arrayServices.count==0){
        return 1;
    }
    return _arrayServices.count;
}

/**
 *每个章节内条目数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrayServices.count==0) {
        return 1;
    }
    return 2;
}

/**
 * 选中Cell响应事件
 * 本方法在子类中不建议重写，如果重写在意味着本组件控制的现实逻辑不起作用
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"BLEDeviceDetailsTableView";
    UITableViewCell *cell=[self obtainCellWith:identifer];
    if (_arrayServices.count==0) {
        cell.textLabel.text=@"获取不到特征值";
        cell.detailTextLabel.text=@"获取不到特征值的值";
        return cell;
    }
    if (characteristicDic) {
        NSDictionary *dic= [_arrayServices objectAtIndex:indexPath.section];
        NSArray *values = [dic allValues];
        id key= [values objectAtIndex:0];
        cell.textLabel.text=[characteristicDic objectForKey:key];
         NSArray *keys=[characteristicDic allKeys];
        if (characteristicValueDic) {
            @try {
                cell.detailTextLabel.text=[characteristicValueDic
                                           objectForKey:[keys objectAtIndex:indexPath.section]];
            }
            @catch (NSException *exception) {
                NSLog(@"数据输出时，产生错误\t%@",exception.reason);
                cell.detailTextLabel.text=exception.reason;
            }
        }else{
            cell.detailTextLabel.text=@"获取不到特征值的值";
        }
    }else{
        cell.textLabel.text=@"获取不到特征值";
    }
    
   
    return cell;

}
//CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
     NSLog(@"centralManagerDidUpdateState 状态更新");
}
//CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
     NSLog(@"peripheralManagerDidUpdateState 状态更新");
}
//可以实现下面的函数，如果连接失败，就会得到回调：
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didFailToConnectPeripheral 连接失败 :\n %@", error.localizedDescription);
}


//必须实现didConnectPeripheral，只要连接成功，就能回调到该函数，开始获取服务。
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSString * u=[[NSString alloc]initWithFormat:@"服务%@" ,
                  _discoveredPeripheral.name ];
    [self handleTableHeander: u];
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
        NSLog(@"didDiscoverServices 获取服务: \n%@",
              [error localizedDescription]);
        //[self cleanup];
        return;
    }
    
    for (CBService *s in peripheral.services)
    {
        NSLog(@"服务的UUID : %@", s.UUID);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{SECTION_NAME:s.UUID.description}];
        [self.arrayServices addObject:dic];
        //发现具体服务的特征值
        [s.peripheral discoverCharacteristics:nil forService:s];
    }
    [self.tableView reloadData];
}

//4. 获取特性
//我们通过discoverCharacteristics来获取每个服务下的特性，通过下面的回调来获取。
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"didDiscoverCharacteristicsForService error : %@",
              [error localizedDescription]);
        return;
    }
    if (characteristicDic==nil){
        characteristicDic=[[NSMutableDictionary alloc]init];
    }
    for (CBCharacteristic *c in service.characteristics)
    {
        self.characteristicNum++;
         NSLog(@"获取特性: \n%@\t 服务名称%@", c,service.UUID.description);
        [characteristicDic setObject:c.description forKey:service.UUID.description];
        [peripheral readValueForCharacteristic:c];
    }
    [self.tableView reloadData];
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
    if (characteristicValueDic==nil) {
        characteristicValueDic=[[NSMutableDictionary alloc]init];
    }
    if (error)
    {
        NSLog(@"didUpdateValueForCharacteristic error : %@", error.localizedDescription);
        //在尾部记录信息
         [characteristicValueDic setValue:error.localizedDescription
                                   forKey:characteristic.UUID.description];
        return;
    }
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    if ([stringFromData isEqualToString:@"EOM"])
    {
        NSLog(@"the characteristic text is END");
        //[peripheral setNotifyValue:NO forCharacteristic:characteristic];
        //[self.centralMgr cancelPeripheralConnection:peripheral];
    }
    
    for (NSMutableDictionary *dic in self.arrayServices)
    {
        NSString *service = [dic valueForKey:SECTION_NAME];
        if ([service isEqual:characteristic.service.UUID.description])
        {
            NSLog(@"characteristic.description : %@", characteristic.UUID.description);
            [dic setValue:characteristic.value.description forKey:characteristic.UUID.description];
            [characteristicValueDic setValue:characteristic.value forKey:characteristic.UUID.description];
        }
    }
}

@end
