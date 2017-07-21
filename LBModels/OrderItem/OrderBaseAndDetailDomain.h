//
//  OrderBaseAndDetailDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerOrderBase;

#import <Foundation/Foundation.h>

@interface OrderBaseAndDetailDomain : NSObject

@property (retain,nonatomic)  CustomerOrderBase *customerOrderBase;

//OrderDetailBusinessDomain
@property (strong,nonatomic)  NSMutableArray *orderDetailBusinessDomain;

@end
