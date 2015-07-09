//
//  BLEInfoTableViewController.h
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import <CoreBluetooth/CoreBluetooth.h>
//定义服务名称
#define SECTION_NAME  @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"

@interface BLEDeviceDetailsTableViewController : BSUITableViewCommonController
<
CBPeripheralManagerDelegate,
CBCentralManagerDelegate,
CBPeripheralDelegate
>

@property (nonatomic, strong) CBCentralManager *centralMgr;
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

// tableview sections，保存蓝牙设备里面的services字典，字典第一个为service，剩下是特性与值
@property (nonatomic, strong) NSMutableArray *arrayServices;

// 用来记录有多少特性，当全部特性保存完毕，刷新列表
@property (atomic, assign) int characteristicNum;

@end
