//
//  CommodityEvaluationParams.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  商品评价请求参数

#import "BasicParams.h"

@interface CommodityEvaluationParams : BasicParams
/** productId	产品ID*/
@property (strong,nonatomic) NSNumber *productId;
/** maxId	最大ID	服务端将返回大于该ID的数据*/
@property (strong,nonatomic) NSNumber *maxId;
/** dataCount	请求的数据条数*/
@property (strong,nonatomic) NSNumber *dataCount;
@end
