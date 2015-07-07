//
//  WaterSending.m
//  民生小区
//
//  Created by L on 15/4/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
//#import "AFNetworking.h"
#import "WaterSending.h"
//#import "AFAppDotNetAPIClient.h"
#import "Conf.h"
#import "ErrorMessage.h"
#import "BSHTTPNetworking.h"
#import "YYHModelRouter.h"

@implementation WaterSending


+ (void)listWaterList:(long)maxId dataCount:(int)dataCount
                            errorUILabel:( UILabel *)errorUILabel
                            block:(BSHTTPResponse)block
{

    NSString *pathparam = [NSString stringWithFormat:@"%d/%d", (int)maxId,dataCount];
    
    NSString *restParam=[WATER_LIST  stringByAppendingString:pathparam];
    BSHTTPNetworking *bsHttp=[BSHTTPNetworking httpManager];
    [bsHttp get:restParam
            pathPattern:WATER_LIST_SCHEMA
            modelClass:[WaterSending class]
            keyPath:@"waterSending"
            block:(BSHTTPResponse)block
            errorUILabel:errorUILabel
     ];
    
}
-(NSString *)description

{
    return [NSString stringWithFormat:@"送水信息，id:%d 产品id:%d \t产品说明:%@\t产品介绍:%@",
                                       self.id,self.businessId,self.name,self.introduce];
    
}
@end
