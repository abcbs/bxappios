//
//  DeleteShoppingCartRequest.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  删除购物车请求

#import <Foundation/Foundation.h>
#import "MiddleNetWorkTool.h"
#import "DeleteShoppingCartParams.h"
#import "DeleteShoppingCartResult.h"

@interface DeleteShoppingCartRequest : NSObject
+ (void)deleteShoppingCartWith:(DeleteShoppingCartParams *)params block:(void(^)(DeleteShoppingCartResult *result,NSError *error,BasicHeader *headr))block;
@end
