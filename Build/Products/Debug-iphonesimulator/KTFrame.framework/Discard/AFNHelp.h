//
//  AFNHelp.h
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@class RegistModel;
@interface AFNHelp : NSObject
#pragma mark --登录
+ (AFHTTPRequestOperation *)getValidateCodeWithBlock:(void (^)(NSDictionary *info, NSError *error))block and:(NSDictionary *)parameters;


#pragma mark --注册

+ (AFHTTPRequestOperation *)inputValidateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

#pragma mark --头像上传
+ (AFHTTPRequestOperation *)upPhotoWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;
#pragma mark --我的订单
+ (AFHTTPRequestOperation *)myOrderWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;
#pragma mark --验证码接口
+ (AFHTTPRequestOperation *)validateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

#pragma mark--订单详情
+ (AFHTTPRequestOperation *)orderDetailWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

@end








