//
//  ViewShoppingCartRequest.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  查看购物车 请求

#import <Foundation/Foundation.h>
#import "MiddleNetWorkTool.h"
#import "ViewShoppingCartParams.h"
#import "ViewShoppingCartResult.h"

@interface ViewShoppingCartRequest : NSObject
+ (void)viewShoppingCartWith:(ViewShoppingCartParams *)params block:(void(^)(ViewShoppingCartResult *result,NSError *error,BasicHeader *headr))block;

@end
