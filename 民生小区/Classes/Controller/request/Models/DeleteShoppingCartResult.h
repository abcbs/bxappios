//
//  DeleteShoppingCartResult.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//   删除购物  返回信息

#import "BasicResponse.h"

@interface DeleteShoppingCartResult : BasicResponse
/**responseBody*/
@property (strong,nonatomic) NSNumber *responseBody;
@end
@interface DeleteShoppingCartList : NSObject
@property (nonatomic, assign)NSString * sessionid;//会话ID

@property (nonatomic, strong)NSArray *shoppingCartList;//购物车产品列表

@property (nonatomic, strong)NSNumber *ID; //购物车ID
@end