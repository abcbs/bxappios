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
    blockArray:(void (^)(NSError *error,ErrorMessage *errorMessage))block{
    
    NSString *url=[Conf urlWithAddShoppingCart] ;
   
    NSLog(@"url:%@", url);
    
    NSDictionary *shoppingDic = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.countorder,@"count",shoppingCart.businessProductId,@"businessProductId",nil];
    
     NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:shoppingCart.sessionId,@"sessionId",shoppingDic,@"shoppingCart", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSDictionary *result = [responseObject objectForKey:@"responseHeader"];
        if ([[result objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
           
            NSObject *resultArr= [responseObject objectForKey:@"responseBody"];
            NSLog(@"%@",resultArr);
//            for (NSDictionary *dict in resultArr) {
//                shoppingCart.currentCount=[dict valueForKeyPath:@""];
//             }
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
        
    }];
    
}
@end
