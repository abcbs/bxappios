//
//  WaterSending.m
//  民生小区
//
//  Created by L on 15/4/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import "AFNetworking.h"
#import "WaterSending.h"
//#import "AFAppDotNetAPIClient.h"
#import "Conf.h"
#import "ErrorMessage.h"
#import "BSHTTPNetworking.h"

@implementation WaterSending


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)waterSendingWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+(NSMutableArray *)waterSending
{
    
    
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:@""];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    //字典转模型
    for (NSDictionary *dic in dicArray) {
        WaterSending *waterSending = [WaterSending waterSendingWithDic:dic];
        [tmpArray addObject:waterSending];
    }
    
    return tmpArray;
}


+ (NSMutableArray *)listWaterList:(long)maxId dataCount:(int)dataCount
                       blockArray:(void (^)(NSMutableArray *waters, NSError *error,ErrorMessage *errorMessage))block
{

    NSString *pathparam = [NSString stringWithFormat:@"%d/%d", (int)maxId,dataCount];
    NSLog(@"pathparam:%@", pathparam);
    
    NSString *url=[[Conf urlWaterList]  stringByAppendingString:pathparam];
    
    NSLog(@"url:%@", url);
    
   // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    BSHTTPNetworking *manager=[BSHTTPNetworking manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [responseObject objectForKey:@"responseHeader"];
          if ([[result objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = [responseObject objectForKey:@"responseBody"];
             NSMutableArray *mutableWater = [NSMutableArray arrayWithCapacity:[resultArr count]];
            for (NSDictionary *dict in resultArr) {
                 WaterSending *ws = [WaterSending waterSendingWithDic:dict];
                 [mutableWater addObject:ws];
            }
            if (block) {
                  block([NSMutableArray arrayWithArray:mutableWater], nil,nil);
            }
          }else{
            ErrorMessage *error = [ErrorMessage initWith:result];
            block([NSMutableArray array], nil,error);
            return ;
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSMutableArray array], error,nil);
        }
        NSLog(@"失败结果: %@", error);
        
    }];
    return  nil;
}
@end
