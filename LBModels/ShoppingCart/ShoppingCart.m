//
//  ShoppingCart.m
//  民生小区
//
//  Created by LouJQ on 15-5-14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ShoppingCart.h"
#import "Conf.h"
#import "ErrorMessage.h"

#import "BSHTTPNetworking.h"

@implementation ShoppingCart


+(void)addCart:( ShoppingCart * )shoppingCart
    blockArray:(void (^)(NSObject *response,
                         NSError *error,ErrorMessage *errorMessage))block{
    
    
    NSDictionary *shoppingDic = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.countorder,@"count",shoppingCart.businessProductId,@"businessProductId",nil];
    
     NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.sessionId,@"sessionId",shoppingDic,@"shoppingCart", nil];
    
     [BSHTTPNetworking httpPOST:WATER_SHOPPCART_ADDCART
                  pathPattern:WATER_SHOPPCART_ADDCART
                  parameters:parameters
                  modelClass:[NSNumber class]
                  keyPath:@""
                  block:(BSHTTPResponse)block
     ];
     
     /*
     [BSHTTPNetworking httpPOST:WATER_SHOPPCART_ADDCART
                          pathPattern:WATER_SHOPPCART_ADDCART
                           parameters:parameters
                           modelClass:[NSNumber class]
                              keyPath:@""
                                block:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                                    
                                    if (block) {
                                        shoppingCart.currentCount=(NSNumber *)response;
                                    }
                                }
     ];
     */
}

-(NSString *)description{
    return [NSString stringWithFormat:@"购物车，商品购量:%@ 商家产品ID:%@ \t当前总量:%@",
            self.countorder,self.businessProductId,self.currentCount];
}

@end
