//
//  UpdateShoppingCartParams.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UpdateShoppingCartParams.h"

@implementation UpdateShoppingCartParams

@end

@implementation UpdateShoppingCartDict

/**
 *  将属性名换为其他key去字典中取值
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end