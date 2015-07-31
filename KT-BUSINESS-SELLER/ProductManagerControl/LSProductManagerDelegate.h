//
//  LSProductManagerDelegate.h
//  KTAPP
//
//  Created by admin on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBModelsHeader.h"

@protocol LSProductManagerDelegate <NSObject>
@optional

/**
 *产品增加
 */
- (void)addBusinessProduct:(BusinessProduct *) product;

/**
 *产品维护
 */
- (void)editedBusinessProduct:(BusinessProduct *) product;


/**
 *产品浏览
 */
- (void)browseBusinessProduct:(BusinessProduct *)product;

/**
 *更新数据
 */
- (void)refreshBusinessProduct:(BusinessProduct *)product;

/**
 *装载初始化数据
 */
-(void) loadBusinessProduct:(BusinessProduct *)product;
@end


