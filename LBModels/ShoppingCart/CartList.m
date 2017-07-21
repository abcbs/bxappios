//
//  CartList.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CartList.h"
#import "ErrorMessage.h"
#import "Conf.h"

#import "WaterSending.h"

#import "BSHTTPNetworking.h"

@implementation CartList

//  waters 是购物车中商品的列表
+(void)queryShoppingCart:(NSString *)sessionId
blockArray:(void (^)(NSMutableArray *waters, NSError *error,ErrorMessage *errorMessage))block;

{
    NSString *url=[WATER_SHOPPCART_USERCARTS stringByAppendingString:sessionId];
  
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [BSHTTPNetworking httpGET:url
                  pathPattern:WATER_SHOPPCART_USERCARTS_SCHEMA
                   modelClass:[CartList class]
                      keyPath:@"CartList"
                        block:(BSHTTPResponse)block
     ];
 }

-(NSString *)description{
    return [NSString stringWithFormat:@"购物车列表，产品数量:%ld 商家产品ID:%@ \t商品名称:%@\t产品优惠价:%@",
            self.cartId,self.businessProductId,self.productName,self.productPreferPrice];
}

@end
