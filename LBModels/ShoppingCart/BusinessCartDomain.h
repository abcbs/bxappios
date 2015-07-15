//
//  BusinessCartDomain.h
//  KTAPP
//  包含购物车与商品属性的Domain，用于展示购物车信息等
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCartDomain : NSObject

/**
 * 购物车ID
 */
@property (nonatomic, assign) NSInteger cartId;

/**
 * 商品ID
 */
@property (nonatomic, assign) NSInteger  businessProductId;

/**
 * 商品类别
 */
@property (nonatomic, assign) NSInteger  businessProductCatalogId;

/**
 * 商品名称
 */
@property (nonatomic, retain) NSString * productName;

/**
 * 购物车数量
 */
@property (nonatomic, assign) NSInteger  count;

/**
 * 商品简介
 */
@property (nonatomic, retain) NSString * productIntroduce;

/**
 * 商品促销价格
 */
@property (nonatomic, assign) float productSalePrice;

/**
 * 商品的德阳卡价格
 */
@property (nonatomic, assign) float productPreferPrice;

/**
 * 资源（也就是商品图片）ID
 */
@property (nonatomic, assign) NSInteger  resourceId;


@end
