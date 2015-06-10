//
//  CommodityEvaluationResult.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CommodityEvaluationResult.h"

@implementation CommodityEvaluationResult
// 告诉框架将来模型中的哪一个属性中存放什么样的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"responseBody": @"CommodityEvaluationList"};
}
@end

@implementation CommodityEvaluationList
/**
 *  将属性名换为其他key去字典中取值
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end
