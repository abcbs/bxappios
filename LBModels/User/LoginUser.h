//
//  User.h
//  APP-BS-MODEL
//  用户注册后，LoginUser ,User,即用户注册信息
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resources.h"

@interface LoginUser : NSObject
//用户名
@property (nonatomic, retain)NSString *userName;
//真实姓名
@property (nonatomic, retain)NSString *realName;
//性别
@property (nonatomic, retain)NSString * sex;
//手机号
@property (nonatomic, retain)NSString * phoneNum;
//验证码
@property (nonatomic, retain)NSString *yanZhengCode;
//密码
@property (nonatomic ,retain)NSString *passWord;
//确认密码
@property (nonatomic ,retain)NSString* commitCode;
//详细地址
@property (nonatomic, retain)NSString *address;
//登陆者UseBaseId
@property (nonatomic, assign)NSInteger userId;
//所属商户
@property (nonatomic, assign) NSInteger businessId;

@property (nonatomic,retain) UIImage *headerImage;

//头像资源
//@property (assign,nonatomic) NSInteger resourceId;
//资源ID转换之后为UIImage
@property (strong, nonatomic) Resources *resourceInfo;

@end
