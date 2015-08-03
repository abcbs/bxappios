//
//  BusinessProductAduit.h
//  KTAPP
//  商家商品审核,维护与监管
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductCatalogue.h"
#import "Resources.h"
#import "ProductBase.h"
#import "BusinessProduct.h"
#import "BusinessBase.h"

@interface BusinessProductAduit : NSObject

@property (assign,nonatomic) NSInteger id;
//商品名称
@property (retain,nonatomic) NSString * name;
//协议
@property (retain,nonatomic) NSString * protocal;
//审批状态
@property (retain,nonatomic) NSString * aduitStatus;
//相关附件
@property (retain,nonatomic) NSString * attachmentUrl;
//申请开始时间
@property (retain,nonatomic) NSDate * startTime;
//审核结束时间
@property (retain,nonatomic) NSDate * finishaduitTime;

//更新时间
@property (retain,nonatomic) NSDate *  updateTime;
//状态
@property (retain,nonatomic) NSString * status;

//申请的商家
@property (assign,nonatomic) NSInteger businessId;
//商品ID
@property (assign,nonatomic) NSInteger productId;
//商品分类
@property (assign,nonatomic) NSInteger productCatalogueId;
//商家产品
@property (assign,nonatomic) NSInteger businessProductId;

@property (retain,nonatomic) BusinessBase *business;
@property (retain,nonatomic) ProductBase *product;
@property (retain,nonatomic) ProductCatalogue *catalogue;
@property (retain,nonatomic) BusinessProduct *businessProduct;

@end
