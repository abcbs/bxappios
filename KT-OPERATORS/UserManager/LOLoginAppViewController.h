//
//  LOLoginAppViewController.h
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"

@interface LOLoginAppViewController : BSUITableViewCommonController

//账号、手机号
@property (strong, nonatomic) IBOutlet UITextField *account;


//密码
@property (strong, nonatomic) IBOutlet UITextField *password;

//重设密码
@property (strong, nonatomic) IBOutlet UIButton *resetPasswordButton;

- (IBAction)resetPasswordClick:(id)sender;

//登陆
@property (strong, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)loginClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerAction:(id)sender;

@end
