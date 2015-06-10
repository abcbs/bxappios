//
//  MiddleNetWorkTool.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//   AFN中间类

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Conf.h"


typedef void (^successBlock)(id json);
typedef void (^failureBlock)(NSError *error);


@interface MiddleNetWorkTool : NSObject

//#warning 需要预先对404等进行预先处理

SingletonH(BasicNetWork)

/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;
/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params  success:(successBlock)success failure:(failureBlock)failure;

/**
 *  put请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params  success:(successBlock)success failure:(failureBlock)failure;


@end
/**
 要使用常规的AFN网络访问
 
 1. AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
 所有的网络请求,均有manager发起
 
 2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 2> 如果返回格式不是JSON的,
 
 // 设置请求格式
 manager.requestSerializer = [AFJSONRequestSerializer serializer];
 // 设置返回格式 为data
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 // 设置返回json排除null
 AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
 jsonResponse.removesKeysWithNullValues = YES;
 
 
 3. 请求格式
 
 AFHTTPRequestSerializer            二进制格式
 AFJSONRequestSerializer            JSON
 AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
 4. 返回格式
 
 AFHTTPResponseSerializer           二进制格式
 AFJSONResponseSerializer           JSON
 AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 AFXMLDocumentResponseSerializer (Mac OS X)
 AFPropertyListResponseSerializer   PList
 AFImageResponseSerializer          Image
 AFCompoundResponseSerializer       组合
 */