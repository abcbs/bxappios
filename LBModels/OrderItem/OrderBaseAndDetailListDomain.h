//
//  OrderBaseAndDetailListDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerOrderBase;
#import <Foundation/Foundation.h>

@interface OrderBaseAndDetailListDomain : NSObject

@property (retain,nonatomic) CustomerOrderBase *customerOrderBase;

//CustomerOrderDetailed
@property (strong,nonatomic) NSMutableArray *customerOrderDetaileds;

@end
