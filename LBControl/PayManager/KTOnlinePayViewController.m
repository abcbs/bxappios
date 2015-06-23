//
//  KTOnlinePayViewController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTOnlinePayViewController.h"
#import "Conf.h"

@interface KTOnlinePayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cartText;

@end

@implementation KTOnlinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Conf navigationControllerHeader:self.navigationController ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)comeBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
