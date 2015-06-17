//
//  Conf.m
//  民生小区
//
//  Created by LouJQ on 15-5-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Conf.h"

#import "AFNetworkReachabilityManager.h"
@implementation Conf




+(NSString *)urlWithAddShoppingCart{
    NSString *url= [KBS_URL
                    stringByAppendingString:WATER_SHOPPCART_ADDCART];
    return url;
}

+(NSString *)urlWaterShoppingDelcartlist{
    NSString *url = [KBS_URL stringByAppendingString:WATER_SHOPPCART_DELCARTLIST];
    return url;
}

+(NSString *)urlWaterShoppingUpdateCart{
    NSString *url = [KBS_URL stringByAppendingString:WATER_SHOPPCART_UPDATECART];
    return url;
}

//对异常信息的处理
//暂无网络
+ (BOOL)isNetwork{
    AFNetworkReachabilityManager *manager = [[AFNetworkReachabilityManager alloc]init];
    if(manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        return NO;
    }
    else{
        return YES;
    }
    
}

@end