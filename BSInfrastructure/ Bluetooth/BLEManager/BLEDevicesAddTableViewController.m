//
//  BLEDevicesAddTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BLEDevicesAddTableViewController.h"


@implementation BLEDevicesAddTableViewController
@synthesize bleInfoDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bleName setTintColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chooseHeaderImages:(id)sender {
}

- (IBAction)saveBLEInfo:(id)sender {
    //从视图中获取数据
    NSString *name=self.bleName.text;
    //CBPeripheral *discoveredPeripheral=[[CBPeripheral alloc]init];
    //discoveredPeripheral.name=name;
    //实例化BLE
    BLEInfo *bleInfo=[[BLEInfo alloc]init];
    //[bleInfo setDiscoveredPeripheral:discoveredPeripheral];
    
    //使用代理做数据处理
    [self.bleInfoDelegate addBLEInfo:bleInfo];
}
@end
