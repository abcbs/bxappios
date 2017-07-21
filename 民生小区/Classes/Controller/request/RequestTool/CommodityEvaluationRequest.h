//
//  CommodityEvaluationRequest.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  商品评价请求工具

#import <Foundation/Foundation.h>
#import "MiddleNetWorkTool.h"
#import "CommodityEvaluationResult.h"
#import "CommodityEvaluationParams.h"

@interface CommodityEvaluationRequest : NSObject
/**
 *
 */
+ (void)commodityEvaluationWith:(CommodityEvaluationParams *)params block:(void(^)(CommodityEvaluationResult *result,NSError *error,BasicHeader *headr))block;

@end
