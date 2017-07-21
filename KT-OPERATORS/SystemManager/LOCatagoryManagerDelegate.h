//
//  LOCatagoryManagerDelegate.h
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBModelsHeader.h"

@protocol LOCatagoryManagerDelegate <NSObject>

@optional

/**
 *产品增加
 */
- (void)addProductCatalogue:(ProductCatalogue *) catagory;

/**
 *产品维护
 */
- (void)editedProductCatalogue:(ProductCatalogue *) catagory;


/**
 *更新数据
 */
- (void)refreshProductCatalogue:(ProductCatalogue *)catagory;

/**
 *装载初始化数据
 */
-(void) loadProductCatalogue:(ProductCatalogue *)catagory;

/**
 *装载初始化数据
 */
-(void) removeProductCatalogue:(ProductCatalogue *)catagory;

@end
