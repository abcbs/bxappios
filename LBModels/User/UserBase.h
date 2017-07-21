//
//  UserBase.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBase : NSObject

@property (assign,nonatomic) NSInteger id;
//姓名
@property (retain,nonatomic) NSString * name;
//住址
@property (retain,nonatomic) NSString * address;
//手机号
@property (retain,nonatomic) NSString *  phone;
//联系电话
@property (retain,nonatomic) NSString * telephone;
//email
@property (retain,nonatomic) NSString * email;

@property (retain,nonatomic) NSString *  status;

@property (assign,nonatomic) NSDate * updateTime;

//一般用户、商户联系人、商户法人、运营人员、匿名
@property (retain,nonatomic) NSString * userType;

//身份证件类型
@property (retain,nonatomic) NSString * entityType;

//身份证件号码
@property (retain,nonatomic) NSString * entityIDNumber;

//头像资源
@property (assign,nonatomic) NSInteger resourceId;

@end
