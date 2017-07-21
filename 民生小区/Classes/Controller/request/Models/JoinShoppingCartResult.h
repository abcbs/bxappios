//
//  JoinShoppingCartResult.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  添加购物车返回信息

#import "BasicResponse.h"

@interface JoinShoppingCartResult : BasicResponse
/**responseBody*/
@property (strong,nonatomic) NSNumber *responseBody;
@property (nonatomic, assign)NSString * sessionid;//会话

@property (nonatomic, strong)NSString *shoppingCart;

@end
@interface JoinShoppingCart : NSObject



@property (nonatomic, assign)NSNumber *count;//数量

@property (nonatomic, assign)NSNumber *businessProductId;//商家产品信息ID
@end