//
//  UpdateShoppingCartResult.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  跟新购物车

#import "UpdateShoppingCartResult.h"

@implementation UpdateShoppingCartResult


// 告诉框架将来模型中的哪一个属性中存放什么样的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"responseBody": @"UpdateShoppingCartDict"};
}
@end
