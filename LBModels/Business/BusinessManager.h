//
//  BusinessManager.h
//  KTAPP
//
//  Created by admin on 15/6/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessBaseDomail.h"
#import "BusinessProduct.h"

@interface BusinessManager : NSObject

//商户管理
+(BusinessManager *)businessManager;

#pragma mark -商家维护
/**
 *根据BusinessBaseDomail装载获得的数据
 */
-(NSMutableArray *) loadBusiness:(BusinessBaseDomail *)business;

/**
 *更新商户信息
 */
-(void)updateBusiness:(BusinessBaseDomail *)business
              atIndex:(NSInteger)index;

-(void)insertBusiness:(BusinessBaseDomail *)business;

-(void)removeBusiness:(BusinessBaseDomail *)business;

-(void)removeBusinessWithIndex:(NSInteger)index;

#pragma mark -商家商品数据
-(NSMutableArray *) loadBusinessProduct:(BusinessProduct *)product;

- (void)insertBusinessProduct:(BusinessProduct *) product;

-(void)updateBusinessProduct:(BusinessProduct *) product
              atIndex:(NSInteger)index;

-(void)removeBusinessProduct:(BusinessProduct *) product;

-(void)removeBusinessProductWithIndex:(NSInteger) index;

@end
