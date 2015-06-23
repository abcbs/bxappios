//
//  KTInformationConfViewController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTInformationConfViewController.h"

@interface KTInformationConfViewController ()
- (IBAction)commentOrder:(UIButton *)sender;

@end

@implementation KTInformationConfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)commentOrder:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTOnlinePayViewController" bundle:nil];
    KTInformationConfViewController *login3 = [storyboard instantiateInitialViewController];
  
    
    
    [self presentViewController:login3 animated:YES completion:nil];
}
- (IBAction)backClick:(id)sender {
}
@end
