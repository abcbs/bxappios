//
//  CustomerOrderDetailed.h
//  KTAPP
//  用户订单详细信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerOrderDetailed : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString * detailOrderNumber;

@property (assign,nonatomic) NSInteger  customerOrderId;

@property (assign,nonatomic) NSInteger  businessOrderId;

@property (assign,nonatomic) NSInteger  businessProductId;

@property (assign,nonatomic) NSInteger  userBaseId;

@property (assign,nonatomic) float preferPrice;

@property (assign,nonatomic) float salePrice;

@property (assign,nonatomic) int  numbers;

@property (assign,nonatomic) float total;

@property (retain,nonatomic) NSString * detailedAduit;

@property (retain,nonatomic) NSString *status;

@property (retain,nonatomic) NSDate *updateTime;


@end
