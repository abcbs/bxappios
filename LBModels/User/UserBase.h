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

@property (retain,nonatomic) NSString * name;

@property (retain,nonatomic) NSString * address;

@property (retain,nonatomic) NSString *  phone;

@property (retain,nonatomic) NSString * telephone;

@property (retain,nonatomic) NSString * email;

@property (retain,nonatomic) NSString *  status;

@property (assign,nonatomic) NSDate * updateTime;

@property (retain,nonatomic) NSString * userType;

@property (retain,nonatomic) NSString * entityIDNumber;

@property (assign,nonatomic) NSInteger resourceId;

@end
