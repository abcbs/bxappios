//
//  UpdateShoppingCartParams.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  跟新购物车  请求参数

#import "BasicParams.h"
@class UpdateShoppingCartDict;
@interface UpdateShoppingCartParams : BasicParams
/**sessionId String 会话ID*/
@property (copy,nonatomic) NSString *sessionId;

/**shoppingCart*/
@property (strong,nonatomic) UpdateShoppingCartDict *shoppingCart;
@end


@interface UpdateShoppingCartDict : NSObject
/**id Long 购物车ID */
@property (strong,nonatomic) NSNumber *ID;
/**count Integer 商品数量*/
@property (strong,nonatomic) NSNumber *count;

@end

