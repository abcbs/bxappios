//
//  DeleteShoppingCartParams.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  删除购物车请求参数

#import "BasicParams.h"
@class DeleteShoppingCartDict;
@interface DeleteShoppingCartParams : BasicParams
/**sessionId 会话ID*/
@property (copy,nonatomic) NSString *sessionId;
/**shoppingCartList*/
@property (strong,nonatomic) NSArray *shoppingCartList;
@end


@interface DeleteShoppingCartDict : NSObject
/** 会话ID id Long  购物车ID*/
@property (strong,nonatomic) NSNumber *ID;
@end
