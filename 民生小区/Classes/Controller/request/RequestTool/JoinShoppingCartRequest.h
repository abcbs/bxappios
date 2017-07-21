//
//  JoinShoppingCartRequest.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiddleNetWorkTool.h"
#import "JoinShoppingCartParams.h"
#import "JoinShoppingCartResult.h"

@interface JoinShoppingCartRequest : NSObject
+ (void)joinShoppingCartWith:(JoinShoppingCartParams *)params block:(void(^)(JoinShoppingCartResult *result,NSError *error,BasicHeader *headr))block;

@end
