//
//  KTHandyViewController.m
//  KTAPP
//
//  Created by admin on 15/6/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTHandyViewController.h"
#import "Conf.h"
@interface KTHandyViewController ()



@end

@implementation KTHandyViewController

@synthesize showSwitchValue;


- (void)viewDidLoad {
    [super viewDidLoad];
    [Conf navigationHeader:self.navigationController ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"提交");
}

- (IBAction)availBluetoothDevice:(id)sender {
    NSLog(@"获取蓝牙设备信息");
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        showSwitchValue.text = @"是";
    }else {
        showSwitchValue.text = @"否";
    }
}

@end
