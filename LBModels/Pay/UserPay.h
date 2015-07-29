//
//  UserPay.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPay : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString * payTool;

@property (retain,nonatomic) NSString * cvv;

@property (retain,nonatomic) NSString * status;

@property (retain,nonatomic) NSString * name;

@property (retain,nonatomic) NSString * phone;

@property (retain,nonatomic) NSString * certificateType; //证件类型

@property (retain,nonatomic) NSString * certificateNumber; //证件号码

@property (retain,nonatomic) NSDate * updateTime;

@property (assign,nonatomic) NSInteger userId;

@end
