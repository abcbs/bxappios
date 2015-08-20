//
//  LOResetPasswordViewController.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOResetPasswordViewController.h"

@interface LOResetPasswordViewController ()

@end

@implementation LOResetPasswordViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    [self initSubViews];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews
{
    
    [BSUIComponentView configButtonStyle:self.checkNumberButton];

    [BSUIComponentView configTextField:self.password];
    [BSUIComponentView configTextField:self.againPassword];
    [BSUIComponentView configTextField:self.phone];
    [BSUIComponentView configTextField:self.checkNumber];
}

-(void)setupData{
    if (self.loginUser) {
        self.phone.text=self.loginUser.userName;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)savePasswordData:(id)sender {
}

- (IBAction)checkNumberClick:(id)sender {
}
@end
