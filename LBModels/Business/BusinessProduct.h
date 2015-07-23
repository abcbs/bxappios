//
//  BusinessProduct.h
//  KTAPP
//  商家产品基本信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resources.h"

@interface BusinessProduct : NSObject

@property (assign,nonatomic) NSInteger  id;

//商品分类标示
@property (assign,nonatomic) NSInteger  productCatalogueId;

//商品基本信息标示
@property (assign,nonatomic) NSInteger  productBaseId;

//商家名称
@property (retain,nonatomic) NSString * businessName;

//商品数量
@property (assign,nonatomic) NSInteger  numbers;

//商品名称
@property (retain,nonatomic) NSString * name;

//商品介绍
@property (retain,nonatomic) NSString *introduce;

//商品发布时间
@property (retain,nonatomic) NSDate * publishTime;

//系统更新时间
@property (retain,nonatomic) NSDate * updateTime;

@property (retain,nonatomic) NSString * warmPrompt;

//赞
@property (retain,nonatomic) NSString * prasie;

@property (retain,nonatomic) NSString * status;

//float 单价
@property (assign,nonatomic) float unitPrice;

//优惠价
@property (assign,nonatomic) float preferPrice;

//销售价格
@property (assign,nonatomic) float salePrice;

//促销开始时间
@property (retain,nonatomic) NSDate * saleStartTime;

//结束时间
@property (retain,nonatomic) NSDate * saleOverTime;

//商家标示
@property (assign,nonatomic) NSInteger  businessId;

//商品审核标示
@property (assign,nonatomic) NSInteger  businessProductAduit;

//是否在售
@property (retain,nonatomic) NSString * isSale;

//头像资源ID
@property (assign,nonatomic) NSInteger resourceId;

//资源ID转换之后为UIImage
@property (retain, nonatomic) UIImage *headerImage;

@property (strong, nonatomic) Resources *resourceInfo;

//商品资源IDs
@property (strong,nonatomic) NSMutableArray * resourceIds;

//商品资源宣传的图片集
@property (strong,nonatomic) NSMutableArray * resourceImages;

//商品资源宣传的图片资源
@property (strong,nonatomic) NSMutableArray * resourceInfoArray;

//是否降价
@property (retain,nonatomic) NSString * onSale;

@property (assign,nonatomic) NSInteger order;


@end
