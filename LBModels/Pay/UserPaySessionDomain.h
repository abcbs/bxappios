//
//  UserPaySessionDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserPay;

@interface UserPaySessionDomain : NSObject

@property (retain,nonatomic) NSString * sessionId;

@property (retain,nonatomic) UserPay * userPay;

@end
