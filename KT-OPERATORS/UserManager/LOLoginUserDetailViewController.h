//
//  LOLoginUserDetailViewController.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserMaintainViewController.h"
#import "LOLoginUserDelegate.h"
#import "LoginUser.h"

@interface LOLoginUserDetailViewController : LOLoginUserMaintainViewController<LOLoginUserDelegate>

@property (weak, nonatomic) id<LOLoginUserDelegate> browseDelegate;

@property (nonatomic,strong) LoginUser *loginUser;

//头像图片
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


//匿名，用户名
@property (strong, nonatomic) IBOutlet UITextField *anonName;


//真实姓名
@property (strong, nonatomic) IBOutlet UITextField *realName;

//密码
@property (strong, nonatomic) IBOutlet UITextField *password;


//地址
@property (strong, nonatomic) IBOutlet UITextField *address;

//手机号
@property (strong, nonatomic) IBOutlet UITextField *phone;


@property (strong, nonatomic) IBOutlet UIButton *manSex;

@property (strong, nonatomic) IBOutlet UIButton *womenSex;

@end
