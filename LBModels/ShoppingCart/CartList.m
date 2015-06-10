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
#import "AFNetworking.h"
#import "WaterSending.h"
#import "MJExtension.h"
@implementation CartList

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

     
+ (instancetype)cartListWithDict:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
+(NSMutableArray *)cartList
{
    
    
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:@""];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    //字典转模型
    for (NSDictionary *dic in dicArray) {
        CartList *waterSending = [CartList cartListWithDict:dic];
        [tmpArray addObject:waterSending];
    }
    
    return tmpArray;
}

//  waters 是购物车中商品的列表
+(NSMutableArray *)urlWithShoppingCart:(NSString *)sessionId
blockArray:(void (^)(NSMutableArray *waters, NSError *error,ErrorMessage *errorMessage))block;

{
//http://192.168.2.103:8090/shoppingcart/usercarts/{244004DDB1D8C514F1AD527AEA2BB0D1}
    NSString *pathparam = [NSString stringWithFormat:@"/%@", sessionId];
    
    NSString *url=[[Conf urlWithShoppingCart] stringByAppendingString:pathparam];
    NSLog(@"%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result = [responseObject objectForKey:@"responseHeader"];
        if ([[result objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = [responseObject objectForKey:@"responseBody"];
            NSMutableArray *mutableWater = [NSMutableArray arrayWithCapacity:[resultArr count]];
            NSArray *array = [CartList objectArrayWithKeyValuesArray:resultArr];
            NSLog(@"%@",array);
            for (NSDictionary *dict in resultArr) {
                CartList *list = [CartList cartListWithDict:dict];
                [mutableWater addObject:list];
                
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutableWater],nil,nil);
            }
        }else{
            ErrorMessage *error = [ErrorMessage initWith:result];
            block( nil,nil,error);
            return ;
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error,nil);
        }
        NSLog(@"失败结果: %@", error);
        
         }];
    return nil;
 }



@end
