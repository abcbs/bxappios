//
//  UserInfoDomain.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBase.h"
#import "UserDetailed.h"
#import "User.h"

@class User;
@class UserDetailed;
@class LoginUser;

@interface UserInfoDomain : NSObject


@property (nonatomic, retain) User *userBase;

@property (nonatomic, retain) UserDetailed *userDetailed;

@property (nonatomic, retain) LoginUser *loginUser;

@end
