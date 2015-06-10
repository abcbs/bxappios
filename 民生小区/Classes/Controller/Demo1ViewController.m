//
//  Demo1ViewController.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 14-12-11.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "Demo1ViewController.h"
#import "DLFixedTabbarView.h"
#import "WaitPayment.h"
#import "AlreadyPayment.h"
#import "AlreadyCommit.h"
#import "AFNHelp.h"
#import "MyOrderModel.h"
@interface Demo1ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) MyOrderModel *order;
- (IBAction)back:(id)sender;

@end

@implementation Demo1ViewController

- (void)viewWillAppear:(BOOL)animated{
   [super viewWillAppear:animated];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
   // self.tabedSlideView.viewControllers = @[ctrl1, ctrl2, ctrl3];
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"待付款" image:[UIImage imageNamed:@"12.png"] selectedImage:[UIImage imageNamed:@"12.png"]];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"已支付" image:[UIImage imageNamed:@"yzfbb2.png"] selectedImage:[UIImage imageNamed:@"yzf0002.png"]];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"已完成" image:[UIImage imageNamed:@"ywcbb2.png"] selectedImage:[UIImage imageNamed:@"ywchh2.png"]];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
    //UINib *nib = [UINib nibWithNibName:@"MyOrderCell" bundle:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            WaitPayment *ctrl = [[WaitPayment alloc] init];
            self.status = @"0";
            return ctrl;
            
        }
        case 1:
        {
            AlreadyPayment *ctrl1 = [[AlreadyPayment alloc] init];
            self.status = @"1";
            return ctrl1;
           
        }
        case 2:
        {
            AlreadyCommit *ctrl2 = [[AlreadyCommit alloc] init];
            self.status = @"2";
            return ctrl2;
            
        }

        default:
            return nil;
    }
}



- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
