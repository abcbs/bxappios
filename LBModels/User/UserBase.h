//
//  UserBase.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBase : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString *name;

@property (retain,nonatomic) NSString *address;

@property (retain,nonatomic) NSString *phone;

@property (retain,nonatomic) NSString *telephone;

@property (retain,nonatomic) NSString *status;

@property (retain,nonatomic) NSDate *updateTime;

@property (retain,nonatomic) NSString *serType;

@property (assign,nonatomic) NSInteger resourceId;

@end
