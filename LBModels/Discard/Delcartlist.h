//
//  Delcartlist.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^successBlock)(id json);
typedef void (^failureBlock)(NSError *error);

@interface Delcartlist : NSObject

@property (nonatomic, assign)NSString *sessionId;

@property (nonatomic, assign) long id;

//@property (nonatomic, )

/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params :(successBlock)success failure:(failureBlock)failure;


@end
