//
//  LOResetPasswordViewController.h
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"

@interface LOResetPasswordViewController : BSUITableViewCommonController

//手机号
@property (strong, nonatomic) IBOutlet UITextField *phone;

//验证码
@property (strong, nonatomic) IBOutlet UITextField *checkNumber;

//密码
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *againPassword;

//获取验证码
@property (strong, nonatomic) IBOutlet UIButton *checkNumberButton;

//修改密码保存
- (IBAction)savePasswordData:(id)sender;

//获取验证码
- (IBAction)checkNumberClick:(id)sender;

@end
