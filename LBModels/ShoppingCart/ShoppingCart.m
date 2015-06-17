//
//  ShoppingCart.m
//  民生小区
//
//  Created by LouJQ on 15-5-14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ShoppingCart.h"
#import "AFNetworking.h"
#import "AFAppDotNetAPIClient.h"
#import "Conf.h"
#import "ErrorMessage.h"

#import "BSHTTPNetworking.h"
#import "BSHTTPNetworkingCustmed.h"

@implementation ShoppingCart

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //self.id = (NSUInteger)[[dic valueForKeyPath:@"id"] integerValue];
    self.countorder = [dic valueForKeyPath:@"count"];
    self.businessProductId = [dic valueForKeyPath:@"businessProductId"];
    
    return self;
    
}

+ (instancetype)initShoppingCartWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}


+(void)addCart:(ShoppingCart * )shoppingCart
    blockArray:(void (^)(NSObject *response,NSError *error,ErrorMessage *errorMessage))block{
    
    NSString *url=[Conf urlWithAddShoppingCart] ;
   
    NSLog(@"url:%@", url);
    
    NSDictionary *shoppingDic = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.countorder,@"count",shoppingCart.businessProductId,@"businessProductId",nil];
    
     NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.sessionId,@"sessionId",shoppingDic,@"shoppingCart", nil];
    /*
    [BSHTTPNetworkingCustmed httpPOST:WATER_SHOPPCART_ADDCART
                  pathPattern:WATER_SHOPPCART_ADDCART
                  parameters:parameters
                  modelClass:[ShoppingCart class]
                  keyPath:@"shoppingCart"
                  block:(BSHTTPResponse)block
     ];
     */
    
    [BSHTTPNetworking httpPOST:WATER_SHOPPCART_ADDCART
                          pathPattern:WATER_SHOPPCART_ADDCART
                           parameters:parameters
                           modelClass:[NSNumber class]
                              keyPath:@""
                                block:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                                    
                                    if (block) {
                                       
                                        //block(nil,error);
                                        
                                        
                                    }
                                }
     ];
    /*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSDictionary *result = [responseObject objectForKey:@"responseHeader"];
        if ([[result objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
           
            NSObject *resultArr= [responseObject objectForKey:@"responseBody"];
            NSLog(@"当前订购数量为%@",resultArr);
            shoppingCart.currentCount=(NSNumber *)resultArr;
            
            if (block) {
                ErrorMessage *error = [ErrorMessage initWith:result];
                block(nil,error);
                
                
            }
            
        }else{
            ErrorMessage *error = [ErrorMessage initWith:result];
            block( nil,error);
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error,nil);
        }
        NSLog(@"失败结果: %@", error);
        
    }];*/
    
}
@end
