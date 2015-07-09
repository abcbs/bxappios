//
//  FirstViewController.h
//  KT-BUSINESS-SELLER
//  懒人服务-周边
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BSUIFrameworkHeader.h"
#import "BSIFTTHeader.h"


//中心扫描设备协议 CBCentralManagerDelegate
@interface BLEDevicesTableViewController : BSUICommonController
<UITableViewDataSource,UITableViewDelegate,CBCentralManagerDelegate ,BLCentralExtention>
//定义2个属性， CBCentralManager用来管理我们的中央设备，
//NSMutableArray用来保存扫描出来的周边设备。
@property (nonatomic, strong) CBCentralManager *centralMgr;
@property (nonatomic, strong) NSMutableArray *arrayBLE;


@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end

