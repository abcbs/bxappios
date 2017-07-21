//
//  BusinessOrder.h
//  KTAPP
//  商家订单
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessOrder : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger orderBaseId;

@property (assign,nonatomic) NSInteger businessId;

@property (retain,nonatomic) NSString * orderNumber;

@property (assign,nonatomic) NSInteger count;

@property (assign,nonatomic) float totalCash;

@property (retain,nonatomic) NSString *detailedAduit;

@property (retain,nonatomic) NSString * status;

@property (retain,nonatomic) NSDate * updateTime;

@end
