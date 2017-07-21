//
//  OrderDetailBusinessDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerOrderDetailed;
@class BusinessProduct;

#import <Foundation/Foundation.h>

@interface OrderDetailBusinessDomain : NSObject

@property (retain,nonatomic) CustomerOrderDetailed *customerOrderDetailed;

@property (retain,nonatomic) BusinessProduct *businessProduct;


@end
