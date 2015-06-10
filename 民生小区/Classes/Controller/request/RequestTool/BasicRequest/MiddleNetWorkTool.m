//
//  MiddleNetWorkTool.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MiddleNetWorkTool.h"

@implementation MiddleNetWorkTool
SingletonM(BasicNetWork)

- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送一个get请求
    // 1.获取AFN的请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //设置网络请求超时 10.0s
    manger.requestSerializer.timeoutInterval = 10.0f;
    // 设置json返回后过滤null
    AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
    jsonResponse.removesKeysWithNullValues = YES;
    manger.responseSerializer = jsonResponse;
    
    // 3.发送请求
    [manger GET: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送一个post请求
    // 1.获取AFN的请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //设置网络请求超时 10.0s
    manger.requestSerializer.timeoutInterval = 10.0f;
    // 设置json返回后过滤null
    AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
    jsonResponse.removesKeysWithNullValues = YES;
    manger.responseSerializer = jsonResponse;
    // 3.发送请求
    [manger POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        [self _operationLog:operation];
        NSLog(@"-------请求成功--------");
        //        NSLog(@"--data---%@--",responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef DEBUG
        [self _operationLog:operation];
        NSLog(@"-------请求失败--------");
#endif
        if (failure) {
            failure(error);
        }
        
    }];
}


- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送一个post请求
    // 1.获取AFN的请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //设置网络请求超时 10.0s
    manger.requestSerializer.timeoutInterval = 10.0f;
    // 设置json返回后过滤null
    AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
    jsonResponse.removesKeysWithNullValues = YES;
    manger.responseSerializer = jsonResponse;
    // 3.发送请求
    [manger PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        [self _operationLog:operation];
        NSLog(@"-------请求成功--------");
        //        NSLog(@"--data---%@--",responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef DEBUG
        [self _operationLog:operation];
        NSLog(@"-------请求失败--------");
#endif
        if (failure) {
            failure(error);
        }
        
    }];
}


#pragma mark - 调试
//请求调试
#ifdef DEBUG
- (void) _operationLog:(AFHTTPRequestOperation *)operation
{
    NSURLRequest *req = operation.request;
    //   NSURLResponse *rsp = operation.response;
    NSString *reqbody = [[NSString alloc]initWithData:req.HTTPBody encoding:NSUTF8StringEncoding];
    NSLog(@"%@",reqbody);
    NSString *rspbody =[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",rspbody);
}
#endif

@end
