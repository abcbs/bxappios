//
//  KTHandyViewController.m
//  KTAPP
//
//  Created by admin on 15/6/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTHandyViewController.h"
#import "Conf.h"
#import "AppDelegate.h"
#import "BSUITableViewInitRuntimeController.h"
#import "BSTableSection.h"
#import "BSTableContentObject.h"
#import "TableViewController.h"
#import "recommendController.h"

@interface KTHandyViewController ()

//@property (retain, nonatomic) BSFCInitRuntimeTableView *bsTableView;

@end

@implementation KTHandyViewController

@synthesize showSwitchValue;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[Conf navigationHeader:self.navigationController ];
    /**
     NSArray *tuPian = [NSArray arrayWithObjects:@"98xc",@"98ss",nil];
     NSArray *mingzi = [NSArray arrayWithObjects:@"洗车",@"送水",nil];
     TableViewController     
     */
    
    /**
     UIButton *titBtn = [[UIButton alloc]initWithFrame:BSRectMake(15, 156 , 100, 26)];
     [titBtn setImage:[UIImage imageNamed:@"xy"] forState:UIControlStateNormal];
     [titBtn setTitle:@"预约服务" forState:UIControlStateNormal];
     [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     titBtn.userInteractionEnabled = NO;
     */
    BSTableContentObject *bsContent=[BSTableContentObject initWithContentObject:@"送水" methodName:nil imageName:@"98ss" vcClass:@"TableViewController"];
    NSMutableArray *arry= [NSMutableArray arrayWithObject: bsContent];
     
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"预约服务" imageName:@"xy" headerViewClass:nil cellClass:nil storyboard:@"KTWaterDetailsViewController" bsContent:arry];
    
    BSTableContentObject *bsCar=[BSTableContentObject initWithContentObject:@"推荐" methodName:nil imageName:@"98xc" colClass:[recommendController class]];
    [bsTable addBSTableContent:bsCar sectionHeader:@"预约服务"];
    
    [bsTable addBSTableContent:bsCar sectionHeader:@"测试服务"];
    [super setValue:bsTable forKey:@"bSTableObjects"];
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
