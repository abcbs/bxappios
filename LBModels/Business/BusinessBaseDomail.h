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

@property (retain,nonatomic) BusinessBase *businessBase;

@property (retain,nonatomic) UserPay *userPay;

//主经营范围，废弃，使用productcatalogueid的第一个元素作为主经营范围
@property (retain,nonatomic) ProductCatalogue *productCatalogue;

@property (retain,nonatomic) UserBase *userBase;

//经营范围分类
@property (retain,nonatomic) NSMutableArray *productCatalogues;
//冗余，或者说重要经营产品的产品分类
//@property (retain,nonatomic) BusinessCatalogue  *businessCatalogue;

@end
