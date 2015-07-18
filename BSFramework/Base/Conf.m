//
//  Conf.m
//  民生小区
//
//  Created by LouJQ on 15-5-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Conf.h"
#import "BSUIFrameworkHeader.h"

@implementation Conf
/**
 
 */
+(NSString *)urlBase
{
    return KBS_URL;
}

+(NSString *)urlWaterList{
    NSString * url=[WATER_LIST
                         stringByAppendingString:WATER_CATA];
     return url;
}

+(NSString *)urlWithShoppingCart{
    NSString *url = [KBS_URL stringByAppendingString:WATER_SHOPPCART_USERCARTS];
    return url;
}
//NSString *str = @"http://192.168.1.103:8090/productcomment/productcomments/1/0/1";
+(NSString *)urlWaterDetailComment{
    NSString * url=WATER_DETAIL_COMMENT;
    
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



#pragma mark --适配的实现
float autoSizeScaleX=1.0;
float autoSizeScaleY=1.0;

+(void)autoSizeScale{
    /*
    if(IS_IPHONE5){
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
        
    }else if (IS_IPHONE_6PLUS){
        autoSizeScaleX = 1.29375;
        autoSizeScaleY=1.2957;
        
    }else if(IS_IPHONE_6){
        autoSizeScaleX=1.171875;
        autoSizeScaleY=1.17429577;
    }else {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
        
    }*/
}

NSString *bsNetstatus=@"缺省状态";

+(void)handleNetworkError:(NSError *)error{
    if (error==nil) {
        bsNetstatus=@"系统连接正常";
    }
    if (error.code<0) {
        bsNetstatus=@"系统连接超时";
    }else{
        bsNetstatus=@"系统连接正常";
    }
}


+(NSInteger )checkNetWork{
    if ([bsNetstatus isEqualToString:@"系统连接超时"]) {
        return networkError;
        
    }else if([bsNetstatus isEqualToString:@"缺省状态"]){
        return NSIntegerMax;
    }else {
        return networkRight;
    }
}

+(NSString *)appVersion{
      NSDictionary *dic=[Conf mainBundle];
      return [dic objectForKey:(NSString *)kCFBundleVersionKey];
}

+(NSDictionary *) mainBundle{
    return [[NSBundle mainBundle] infoDictionary] ;
}

+(NSString *)appInfo{
    NSString *infoPlistPath=[[NSBundle mainBundle]
                        pathForResource:@"InfoPlist" ofType:@"strings" ];
    
    NSDictionary *infoPlistDic=[NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
    NSString *appProjectName=[infoPlistDic valueForKey:@"CFBundleDisplayName"];
    //NSArray *data = [NSArray arrayWithContentsOfFile:dataPath];
    
    //NSDictionary *dic=[Conf mainBundle];
    //获取项目名称
   // NSString *executableFile = [dic objectForKey:(NSString *)kCFBundleExecutableKey];
    return appProjectName;
}


@end