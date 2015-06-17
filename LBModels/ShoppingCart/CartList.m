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



@end
