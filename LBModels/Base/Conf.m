//
//  Conf.m
//  民生小区
//
//  Created by LouJQ on 15-5-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Conf.h"


#import "AFNetworkReachabilityManager.h"
@implementation Conf



NSString *const KBS_URL=@"http://192.168.1.104:8090/";
NSString *const WATER_LIST=@"water/waterinformations";
NSString *const WATER_CATA=@"/1001/";
NSString *const WATER_DETAIL_COMMENT=@"productcomment/productcomments/";


NSString *const WATER_SHOPPCART = @"shoppingcart/usercarts";

NSString *const WATER_SHOPPCART_ADDCART=@"shoppingcart/addcart";
NSString *const WATER_SHOPPCART_USERCARTS=@"shoppingcart/usercarts";
NSString *const WATER_SHOPPCART_DELCARTLIST = @"shoppingcart/delcartlist";
NSString *const WATER_SHOPPCART_UPDATECART = @"shoppingcart/updatecart";

/**
 
 */
+(NSString *)urlBase
{
    return [[NSString alloc] initWithString:KBS_URL];
}
+(NSString *)urlWaterList{
    NSString * url=[[[NSString alloc] initWithString:WATER_LIST]
                         stringByAppendingString:WATER_CATA];
     return url;
}



//NSString *str = @"http://192.168.1.103:8090/productcomment/productcomments/1/0/1";
+(NSString *)urlWaterDetailComment{
    NSString * url=[[NSString alloc] initWithString:WATER_DETAIL_COMMENT];
    
    return url;
}


+ (NSString *)urlWithShoppingCart
{
    NSString *url= [[[NSString alloc] initWithString:KBS_URL]
                    stringByAppendingString:WATER_SHOPPCART_USERCARTS];
    return url;
}


+(NSString *)urlWithAddShoppingCart{
    NSString *url= [[[NSString alloc] initWithString:KBS_URL]
                    stringByAppendingString:WATER_SHOPPCART_ADDCART];
    return url;
}

+(NSString *)urlWaterShoppingDelcartlist{
    NSString *url = [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:WATER_SHOPPCART_DELCARTLIST];
    return url;
}

+(NSString *)urlWaterShoppingUpdateCart{
    NSString *url = [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:WATER_SHOPPCART_UPDATECART];
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


//+(NSString *)urlWithAddCart{
//    return nil;
//}
@end