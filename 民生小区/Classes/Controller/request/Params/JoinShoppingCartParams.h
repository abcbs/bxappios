//
//  JoinShoppingCartParams.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  加入购物测请求

#import "BasicParams.h"

@class JoinShoppingCartDict;
@interface JoinShoppingCartParams : BasicParams
/** sessionId	String	会话ID*/
@property (copy,nonatomic) NSString * sessionId;
/**shoppingCart*/
@property (strong,nonatomic) JoinShoppingCartDict *shoppingCart;

@end

@interface JoinShoppingCartDict : NSObject
/**count	Long	数量*/
@property (strong,nonatomic) NSNumber *count;
/**businessProductId	Long	商家产品信息ID	商家产品详细列表中的responseBody.id的值*/
@property (strong,nonatomic) NSNumber *businessProductId;
@end
