//
//  FirstViewController.m
//  KT-BUSINESS-SELLER
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BLEDevicesTableViewController.h"
#import "BLEInfo.h"
#import "BSIFTTHeader.h"

@interface BLEDevicesTableViewController ()<BLCentralExtention>
{
    NSInteger bleIndex;
}
@end

@implementation BLEDevicesTableViewController
@synthesize centralMgr;
@synthesize arrayBLE;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //中央设备创建很简单，第一个参数代表 CBCentralManager 代理;
    //第二个参数设置为nil，因为Peripheral Manager将Run在主线程中。如果你想用不同的线程做更加复杂的事情，你需要创建一个队列（queue）并将它放在这儿。
    self.centralMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.arrayBLE = [[NSMutableArray alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated{
 
    //[self.centralMgr scanForPeripheralsWithServices:nil options:nil];
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    // Don't keep it going while we're not showing.
    //[centralMgr stopScan];
    //NSLog(@"Scanning stopped");
    
    [super viewWillDisappear:animated];
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
    UITableViewCell *cell=[self obtainCellWith:identifer];
    
    if ([self.arrayBLE count]>0) {
        BLEInfo *ble=[self.arrayBLE objectAtIndex:indexPath.row];
        
       CBPeripheral *p= ble.discoveredPeripheral;
        BOOL isc=[[ble discoveredPeripheral] state] ==CBPeripheralStateConnected;
        
       NSString *state=(isc==YES )? @"Connected" : @"Not connected";
        NSString *name=@"无名设备";
        if (p.name==nil) {
            name =@"无名设备";
        }else{
            name=p.name ;
        }
        cell.textLabel.text=name;
        if (ble!=nil&&ble.rssi) {
            if([ble.rssi isKindOfClass:[NSNumber class]]){
            cell.detailTextLabel.text= [[ble.rssi stringValue]
                                        stringByAppendingFormat:@"\t连接状态:\t%@",state ];
            }else if([ble.rssi isKindOfClass:[NSArray class]]){
                //NSArray *arrayRssi=(NSArray *)ble.rssi;
                cell.detailTextLabel.text= [NSString
                                             stringWithFormat:@"\t连接状态:\t%@",state  ];
            }
        }
          
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayBLE.count;
}

/**
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLEInfo *bleInfo;
    if (tableView == self.tableView)
    {//将来的搜索页做准备
        bleInfo = arrayBLE[indexPath.row];
        bleIndex = indexPath.row;
        @try {
            [self performSegueWithIdentifier:@"BLEConnectionSegue" sender:nil];
        }
        @catch (NSException *exception) {
            NSLog(@"跳转错误，%@",exception.reason);
            [self navigating:self storybord:@"LSBLEIFTTUpHoldMain" identity:@"BLEDevicesTableViewController" canUseStoryboard:YES];
        }
     }
    else
    {
        [self performSegueWithIdentifier:@"BLEConnectionSegue" sender:nil];
        bleIndex = [arrayBLE indexOfObject:bleInfo];
    }
}


/**
 *自定义划动时delete按钮内容
 */
- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除?";
}

/**
 *删除
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Remove the row from data model
        long row=indexPath.row;
        //if (row==0) {
        //    return;
        //}
        [self.arrayBLE removeObjectAtIndex:row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //Request table view to reload
        [tableView reloadData];
        
    }
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
            BSLog(@"=============查找周边设备:开始==============");
            [self.centralMgr scanForPeripheralsWithServices:nil options:nil];
            break;
            
        case CBCentralManagerStatePoweredOff:
        {
            
            BSLog(@"=============查找周边设备:关闭==============");
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            BSLog(@"=============查找周边设备:同步==============");
            break;
        }
            
        case CBCentralManagerStateUnknown:
        {
            BSLog(@"=============查找周边设备:状态未知==============");
            break;
        }

        case CBCentralManagerStateResetting:
        {
            BSLog(@"=============查找周边设备:状态重置==============");
            break;
        }
        default:
            BSLog(@"Central Manager did change state");
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
    BSLog(@"查到的周边设备，\n%@",discoveredBLEInfo.description);
    // update tableview
    [self saveBLE:discoveredBLEInfo];
}

- (BOOL)saveBLE:(BLEInfo *)discoveredBLEInfo
{
    BSLog(@"发现设备，更新数据");
    //modified LiuJQ for test
    
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
    //BLEConnectionSegue
    if ([segue.identifier isEqualToString:@"BLEConnectionSegue"])
    {
        BLEDeviceDetailsTableViewController *evc = (BLEDeviceDetailsTableViewController *)segue.destinationViewController;
        evc.centralMgr=self.centralMgr;
        BLEInfo *bleInfo=( BLEInfo *)[self.arrayBLE objectAtIndex:bleIndex];
        evc.discoveredPeripheral=bleInfo.discoveredPeripheral;
        evc.bleInfoDelegate = self;
    }else if ([segue.identifier isEqualToString:@"DeviceAddedSegue"]){
        BLEDevicesAddTableViewController *avc=(BLEDevicesAddTableViewController *)segue.destinationViewController;
        avc.bleInfoDelegate=self;
    }
}

- (void)refreshBLEInfo:(BLEInfo *)bleInfo{
    NSLog(@"refreshBLEInfo,%@",self.description);
    [self.arrayBLE removeObjectAtIndex:bleIndex];
    [self.arrayBLE insertObject:bleInfo atIndex:bleIndex];
    [self.tableView reloadData];
    
}
- (void)addBLEInfo:(BLEInfo *)bleInfo{
    NSLog(@"addBLEInfo,%@",self.description);
    //[self.arrayBLE removeObjectAtIndex:bleIndex];
    [self.arrayBLE insertObject:bleInfo atIndex:bleIndex];
    [self.tableView reloadData];
    
    
}
- (void)editBLEInfo:(BLEInfo *)bleInfo{
    BSLog(@"addBLEInfo,%@",self.description);
    
}


@end


