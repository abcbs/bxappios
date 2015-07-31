//
//  LOBusinessControllerDelegate.h
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBModelsHeader.h"

@protocol LOBusinessManagerDelegate <NSObject>

@optional

/**
 *产品增加
 */
- (void)sendAddBusiness:(BusinessBaseDomail *) business;

/**
 *产品维护
 */
- (void)sendEditedBusiness:(BusinessBaseDomail *) business;


/**
 *产品浏览
 */
- (void)sendBrowseBusiness:(BusinessBaseDomail *)business;

/**
 *更新数据
 */
- (void)refreshBusiness:(BusinessBaseDomail *)business;

/**
 *装载初始化数据
 */
-(void) loadBusiness:(BusinessBaseDomail *)business;

@end
