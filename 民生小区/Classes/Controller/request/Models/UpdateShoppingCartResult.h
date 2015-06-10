//
//  UpdateShoppingCartResult.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//   跟新购物车  返回信息

#import "BasicResponse.h"

@interface UpdateShoppingCartResult : BasicResponse
/**responseBody*/
@property (strong,nonatomic) NSNumber *responseBody;

@property (nonatomic, strong)NSString *shoppingCart;

@property (nonatomic, assign)NSString * sessionid;//会话ID
@end
@interface UpdateShoppingCartList : NSObject



@property (nonatomic, assign)NSNumber *count;//商品数量

@property (nonatomic, strong)NSNumber *ID; //购物车ID



@end