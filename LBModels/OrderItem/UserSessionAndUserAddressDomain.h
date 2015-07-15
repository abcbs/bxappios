//
//  UserSessionAndUserAddressDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class UserSession;
@class UserOrderAddress;

#import <Foundation/Foundation.h>

@interface UserSessionAndUserAddressDomain : NSObject

@property (retain,nonatomic) UserSession *userSession;

@property (retain,nonatomic) UserOrderAddress *userOrderAddress;

@end
