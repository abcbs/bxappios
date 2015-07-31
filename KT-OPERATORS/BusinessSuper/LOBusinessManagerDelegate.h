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
- (void)addBusiness:(BusinessBaseDomail *) business;

/**
 *产品维护
 */
- (void)editedBusiness:(BusinessBaseDomail *) business;


/**
 *更新数据
 */
- (void)refreshBusiness:(BusinessBaseDomail *)business;

/**
 *装载初始化数据
 */
-(void) loadBusiness:(BusinessBaseDomail *)business;

/**
 *装载初始化数据
 */
-(void) removeBusiness:(BusinessBaseDomail *)business;
@end
