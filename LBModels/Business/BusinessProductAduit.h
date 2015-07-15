//
//  BusinessProductAduit.h
//  KTAPP
//  商家商品审核,维护与监管
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductAduit : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger productId;

@property (assign,nonatomic) NSInteger productCatalogueId;

@property (retain,nonatomic) NSString * name;

@property (retain,nonatomic) NSString * protocal;

@property (retain,nonatomic) NSString * aduitStatus;

@property (retain,nonatomic) NSString * attachmentUrl;

@property (retain,nonatomic) NSDate * startTime;

@property (assign,nonatomic) float unitprice;

@property (assign,nonatomic) NSInteger numbers;

@property (retain,nonatomic) NSDate *  updateTime;

@property (retain,nonatomic) NSString * status;

@property (assign,nonatomic) NSInteger businessId;

@property (retain,nonatomic) NSDate * finishaduitTime;


@end
