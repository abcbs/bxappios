//
//  BusinessBaseDomail.h
//  KTAPP
//  针对于业务的Domain对象，是BusinessBase、UserPay、
//  ProductCatalogue、UserBase的属性集合
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusinessBase;
@class UserPay;
@class ProductCatalogue;
@class UserBase;
@class BusinessCatalogue;

@interface BusinessBaseDomail : NSObject

//商家基本信息
@property (retain,nonatomic) BusinessBase *businessBase;

//用户支付工具
@property (retain,nonatomic) UserPay *userPay;

//法人，有支付权限
@property (retain,nonatomic) UserBase *artificial;

//联系人，合伙人
@property (strong,nonatomic) NSMutableArray *contractUsers;

//商家的经营返回应当是数组
@property (strong,nonatomic) NSMutableArray *productCatalogues;//产品分类

//本地装载数据路径
+ (NSString *)loadForBusinessList;
@end
