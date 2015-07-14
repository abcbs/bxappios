//
//  LoginUser.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger userId;

@property (assign,nonatomic) NSInteger businessId;

@property (retain,nonatomic) NSString *status;

@property (retain,nonatomic) NSString *updateTime;

@property (retain,nonatomic) NSString *online;

@property (retain,nonatomic) NSString *username;

@property (retain,nonatomic) NSString *password;

/**
 * 确认密码，此字段只在注册时使用，在数据库中无对应字段
 */
@property (retain,nonatomic) NSString *confirmPassword;


@end
