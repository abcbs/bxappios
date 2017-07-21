//
//  UserBaseAndSessionDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerOrderBase;

#import <Foundation/Foundation.h>

@interface UserBaseAndSessionDomain : NSObject

@property (retain,nonatomic) NSString * sessionId;

@property (retain,nonatomic) CustomerOrderBase * customerOrderBase;


@end
