//
//  ViewShoppingCartResult.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  

#import "ViewShoppingCartResult.h"

@implementation ViewShoppingCartResult
// 告诉框架将来模型中的哪一个属性中存放什么样的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"responseBody": @"ViewShoppingCartDict"};
}
@end


@implementation ViewShoppingCartDict

@end