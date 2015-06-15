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
#import "YYHModelRouter.h"

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
    
    NSString *restParam=[[Conf urlWaterList]  stringByAppendingString:pathparam];
    BSHTTPNetworking *bsHttp=[BSHTTPNetworking httpManager];
    [bsHttp get:restParam
            pathPattern:WATER_LIST_SCHEMA
            modelClass:[WaterSending class]
            keyPath:@"waterSending"
        block:^(NSMutableArray *waters,NSError *error, ErrorMessage *bsErrorMessage){
            if (block&&waters!=nil) {
                block(waters,nil,nil);
            }else if(block&&error){
                block(nil,error,nil);
            }else{
                block(nil,nil,bsErrorMessage);
            }
        }
     ];
    return  nil;
}
@end
