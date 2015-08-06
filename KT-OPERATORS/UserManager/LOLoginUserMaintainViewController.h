//
//  LOLoginUserMaintainViewController.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "LOLoginUserDelegate.h"
#import "LoginUser.h"

@interface LOLoginUserMaintainViewController : BSUITableViewCommonController

@property (weak, nonatomic) id<LOLoginUserDelegate> editDelegate;

@property (nonatomic,strong) LoginUser *loginUser;

//头像图片
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


//匿名，用户名
@property (strong, nonatomic) IBOutlet UITextField *anonName;


//真实姓名
@property (strong, nonatomic) IBOutlet UITextField *realName;

//密码
@property (strong, nonatomic) IBOutlet UITextField *password;

//确认明明
@property (strong, nonatomic) IBOutlet UITextField *againPassword;

//地址
@property (strong, nonatomic) IBOutlet UITextField *address;

//手机号
@property (strong, nonatomic) IBOutlet UITextField *phone;


//验证码
@property (strong, nonatomic) IBOutlet UITextField *checkNumber;


#pragma mark -操作
//保存数据
- (IBAction)saveLoginUserData:(id)sender;

//头像选择
- (IBAction)headerImageClick:(id)sender;


//手机验证码获取
- (IBAction)phoneCheckNumberClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *manSex;

@property (strong, nonatomic) IBOutlet UIButton *womenSex;


//男性别选择
- (IBAction)menSexClick:(id)sender;

//女性别选择
- (IBAction)womanSexClick:(id)sender;

@end
