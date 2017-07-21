//
//  AFNHelp.h
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>
@class RegistModel;
@interface AFNHelp : NSObject
#pragma mark --登录
+ (NSURLSessionDataTask *)getValidateCodeWithBlock:(void (^)(NSDictionary *info, NSError *error))block and:(NSDictionary *)parameters;


#pragma mark --注册

+ (NSURLSessionDataTask *)inputValidateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

#pragma mark --头像上传
+ (NSURLSessionDataTask *)upPhotoWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;
#pragma mark --我的订单
+ (NSURLSessionDataTask *)myOrderWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;
#pragma mark --验证码接口
+ (NSURLSessionDataTask *)validateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

#pragma mark--订单详情
+ (NSURLSessionDataTask *)orderDetailWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters;

@end








