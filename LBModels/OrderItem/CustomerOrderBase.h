//
//  CustomerOrderBase.h
//  KTAPP
//  用户订单基础信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerOrderBase : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString * orderNumber;

@property (assign,nonatomic) float totalCash;

@property (assign,nonatomic) int totalNumbers;

@property (retain,nonatomic) NSString * orderAduit;

@property (retain,nonatomic) NSDate * updateTime;

@property (retain,nonatomic) NSString * detailedAduit;

@property (retain,nonatomic) NSString * status;

@property (assign,nonatomic) NSInteger userBaseId;

@property (assign,nonatomic) NSInteger orderAddressId;

@property (retain,nonatomic) NSString *isInvoice; //是否开发票

@property (retain,nonatomic) NSString * isClub; //公司还是个人

@property (retain,nonatomic) NSString * invoiceTitle; //发票抬头

@end
