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

+(void)navigationHeader:(UINavigationController *)navigationController{
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [navigationController.navigationBar setBackgroundColor
     :[UIColor redColor]];
}

+(UIImageView *)navigationHeaderWithImage:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                                                                          NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    NSString *image = [NSString stringWithFormat:imageName];
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}

#pragma mark --适配的实现
float autoSizeScaleX=1.0;
float autoSizeScaleY=1.0;


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
        return -1001;
        
    }else if([bsNetstatus isEqualToString:@"缺省状态"]){
        return NSIntegerMax;
    }else {
        return networkRight;
    }
}

@end