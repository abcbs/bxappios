//
//  UpdateShoppingCartRequest.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  跟新购物车

#import <Foundation/Foundation.h>
#import "MiddleNetWorkTool.h"
#import "UpdateShoppingCartParams.h"
#import "UpdateShoppingCartResult.h"

@interface UpdateShoppingCartRequest : NSObject

+ (void)updateShoppingCartWith:(UpdateShoppingCartParams *)params block:(void(^)(UpdateShoppingCartResult *result,NSError *error,BasicHeader *headr))block;

@end
