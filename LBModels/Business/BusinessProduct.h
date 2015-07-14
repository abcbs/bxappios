//
//  BusinessProduct.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProduct : NSObject

@property (assign,nonatomic) NSInteger  id;

@property (assign,nonatomic) NSInteger  productCatalogueId;

@property (assign,nonatomic) NSInteger  productBaseId;

@property (retain,nonatomic) NSString * businessName;

@property (assign,nonatomic) NSInteger  numbers;

@property (retain,nonatomic) NSString * name;

@property (retain,nonatomic) NSString *introduce;

@property (retain,nonatomic) NSDate * publishTime;

@property (retain,nonatomic) NSDate * updateTime;

@property (retain,nonatomic) NSString * warmPrompt;

@property (retain,nonatomic) NSString * prasie;

@property (retain,nonatomic) NSString * status;

//float
@property (assign,nonatomic) float unitPrice;

@property (assign,nonatomic) float preferPrice;

@property (assign,nonatomic) float salePrice;

@property (retain,nonatomic) NSDate * saleStartTime;

@property (retain,nonatomic) NSDate * saleOverTime;

@property (assign,nonatomic) NSInteger  businessId;

@property (assign,nonatomic) NSInteger  businessProductAduit;

@property (retain,nonatomic) NSString * isSale;

@property (assign,nonatomic) NSInteger resourceId;
//资源ID
@property (retain,nonatomic) NSMutableArray * resourceIds;

@property (retain,nonatomic) NSString * onSale;

@property (assign,nonatomic) NSInteger order;

@end
