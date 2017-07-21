//
//  BusinessOrderDetailDomain.h
//  KTAPP
//  商家订单详细
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class BusinessBase;
@class BusinessOrder;

#import <Foundation/Foundation.h>

@interface BusinessOrderDetailDomain : NSObject

@property (retain,nonatomic) BusinessBase * businessBase;

@property (retain,nonatomic) BusinessOrder * businessOrder;

//OrderDetailBusinessDomain
@property (strong,nonatomic) NSMutableArray * orderDetailBusinessDomain;

@end
