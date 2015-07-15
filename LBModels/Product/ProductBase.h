//
//  ProductBase.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductCatalogue;
@interface ProductBase : NSObject

//id
@property (assign,nonatomic) long id;

//商品名称
@property (retain,nonatomic) NSString *name;

//商品介绍
@property (retain,nonatomic) NSString *introduce;

//更新时间
@property (retain,nonatomic) NSDate *updateTime;

//状态
@property (retain,nonatomic) NSString *status;

//单价，标准价格
@property (retain,nonatomic) NSNumber *unit;

//商品规格
@property (retain,nonatomic) NSString *specification;

//商品备注
@property (retain,nonatomic) NSString *comment;

//商品分类，应当引用ProductCatalogue
@property (assign,nonatomic) NSInteger productCatalogueId;

@property (retain,nonatomic) ProductCatalogue *catalogue;

@end
