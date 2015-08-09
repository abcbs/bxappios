//
//  LOLoginAppViewController.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginAppViewController.h"

@interface LOLoginAppViewController ()

@end

@implementation LOLoginAppViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews
{

    [BSUIComponentView configButtonStyle:self.loginButton];
    [BSUIComponentView configButtonStyle:self.resetPasswordButton];
    [BSUIComponentView configTextField:self.password];
    [BSUIComponentView configTextField:self.account];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)modifiedStyle{
    self.resetPasswordButton.backgroundColor=[BSUIComponentView navigationColor];
    self.loginButton.backgroundColor=[BSUIComponentView navigationColor];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetPasswordClick:(id)sender {
}
- (IBAction)loginClick:(id)sender {
}
@end
