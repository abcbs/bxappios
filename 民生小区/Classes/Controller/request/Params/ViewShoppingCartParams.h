//
//  ViewShoppingCartParams.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  查看购物车 请求参数

#import "BasicParams.h"

@interface ViewShoppingCartParams : BasicParams
/**sessionId 会话ID*/
@property (copy,nonatomic) NSString *sessionId;
@end
