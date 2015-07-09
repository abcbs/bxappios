//
//  FirstViewController.m
//  KT-BUSINESS-SELLER
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BLEDevicesTableViewController.h"
#import "BLEInfo.h"
#import "BSIFTTHeader.h"

@interface BLEDevicesTableViewController ()<BLCentralExtention>

@end

@implementation BLEDevicesTableViewController
@synthesize centralMgr;
@synthesize arrayBLE;
@synthesize tableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //中央设备创建很简单，第一个参数代表 CBCentralManager 代理;
    //第二个参数设置为nil，因为Peripheral Manager将Run在主线程中。如果你想用不同的线程做更加复杂的事情，你需要创建一个队列（queue）并将它放在这儿。
    self.centralMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.arrayBLE = [[NSMutableArray alloc] init];
    
    
    if (tableView==nil) {
        NSLog(@"tableView is null");
    }else{
        self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.tableView.frame=BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT);
    }
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"周边首页";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"HandDefaultCell";
    UITableViewCell *cell=nil;
    
    cell=[self.tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    if ([self.arrayBLE count]>0) {
        BLEInfo *ble=[self.arrayBLE objectAtIndex:indexPath.row];
        
       CBPeripheral *p= ble.discoveredPeripheral;
    
       NSString *state=[[ble discoveredPeripheral] isConnected] ? @"Connected" : @"Not connected";
        if (p.name==nil) {
            cell.textLabel.text =@"无名设备";
        }else{
            cell.textLabel.text =p.name ;
        }
        cell.detailTextLabel.text=  [[ble.rssi stringValue] stringByAppendingString:state];
        //cell.detailTextLabel.text=@"Not connected";
        
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayBLE.count;
}

//实现centralManagerDidUpdateState。
//当Central Manager被初始化，我们要检查它的状态，以检查运行这个App的设备是不是支持BLE。
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
     NSLog(@"Central Manager centralManagerDidUpdateState...");
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
            //scanForPeripheralsWithServices:options:方法是中央设备开始扫描，可以设置为特定UUID来指，来差找一个指定的服务了。
            NSLog(@"=============查找周边设备:开始==============");
            [self.centralMgr scanForPeripheralsWithServices:nil options:nil];
            break;
            
        case CBCentralManagerStatePoweredOff:
        {
            
            NSLog(@"=============查找周边设备:关闭==============");
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            NSLog(@"=============查找周边设备:同步==============");
            break;
        }
            
        case CBCentralManagerStateUnknown:
        {
            NSLog(@"=============查找周边设备:状态未知==============");
            break;
        }

        case CBCentralManagerStateResetting:
        {
            NSLog(@"=============查找周边设备:状态重置==============");
            break;
        }
        default:
            NSLog(@"Central Manager did change state");
            break;
            

    }
}

//当发起扫描之后，我们需要实现 centralManager:didDiscoverPeripheral:advertisementData:RSSI: 通过该回调来获取发现设备。

//这个回调说明着广播数据和信号质量(RSSI-Received Signal Strength Indicator)的周边设备被发现。通过信号质量，可以用判断周边设备离中央设备的远近。
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    BLEInfo *discoveredBLEInfo = [[BLEInfo alloc] init];
    discoveredBLEInfo.discoveredPeripheral = peripheral;
    discoveredBLEInfo.rssi = RSSI;
    NSLog(@"查到的周边设备，\n%@",discoveredBLEInfo.description);
    // update tableview
    [self saveBLE:discoveredBLEInfo];
}

- (BOOL)saveBLE:(BLEInfo *)discoveredBLEInfo
{
    NSLog(@"发现设备，更新数据");
    for (BLEInfo *info in self.arrayBLE)
    {
        if ([info.discoveredPeripheral.identifier.UUIDString isEqualToString:discoveredBLEInfo.discoveredPeripheral.identifier.UUIDString])
        {
            return NO;
        }
    }
    
    [self.arrayBLE addObject:discoveredBLEInfo];
    [self.tableView reloadData];
    return YES;
}

#pragma mark -
#pragma mark Stroyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //到连接测试界面:BLEConnectionSegue
    //
    if ([segue.identifier isEqualToString:@"BLEConnectionSegue"])
    {
        BLEDeviceDetailsTableViewController *evc = (BLEDeviceDetailsTableViewController *)segue.destinationViewController;
        evc.bleInfoDelegate = self;
    }else if ([segue.identifier isEqualToString:@"DeviceAddedSegue"]){
        BLEDevicesAddTableViewController *avc=(BLEDevicesAddTableViewController *)segue.destinationViewController;
        avc.bleInfoDelegate=self;
    }
}

- (void)refreshBLEInfo:(BLEInfo *)bleInfo{
    NSLog(@"refreshBLEInfo,%@",self.description);
    
}
- (void)addBLEInfo:(BLEInfo *)bleInfo{
    NSLog(@"addBLEInfo,%@",self.description);
    
}
- (void)editBLEInfo:(BLEInfo *)bleInfo{
    NSLog(@"addBLEInfo,%@",self.description);
    
}
@end


