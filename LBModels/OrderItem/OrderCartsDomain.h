//
//  OrderCartsDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerOrderBase;
@class UserOrderAddress;
@class BusinessCartDomain;

#import <Foundation/Foundation.h>

@interface OrderCartsDomain : NSObject

@property (retain,nonatomic) NSString * sessionId;

//BusinessCartDomain
@property (retain,nonatomic) NSMutableArray * businessCartDomain;

@property (retain,nonatomic)  CustomerOrderBase * customerOrderBase;

@property (retain,nonatomic)  UserOrderAddress * userOrderAddress;

@end
