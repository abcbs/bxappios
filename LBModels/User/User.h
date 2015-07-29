//
//  User.h
//  APP-BS-MODEL
//  用户注册后，LoginUser ,User,即用户注册信息
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
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

@property (nonatomic, assign)NSInteger userId;

@property (nonatomic, assign) NSInteger businessId;

@end
