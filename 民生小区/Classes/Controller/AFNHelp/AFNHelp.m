//
//  AFNHelp.m
//  机械网登陆注册
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import "AFNHelp.h"
#import "AFAppDotNetAPIClient.h"
#import "RegistModel.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "RegisterViewController.h"
#import "Conf.h"
//#import "RegisterInfo.h"

//凡是碰到用户名，密码，电话号码，用户id时需要往服务器传数据时需要加密，如果从服务器取到的数据里面有用户名，密码，电话号码，用户id，需要解密


@implementation AFNHelp

#pragma mark --登录

+ (NSURLSessionDataTask *)getValidateCodeWithBlock:(void (^)(NSDictionary *info, NSError *error))block and:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSString *url = Login_url;
    
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    return [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
        
        if (block) {
            block([NSDictionary dictionary],nil);
        }
    }];
}

#pragma mark --注册

+ (NSURLSessionDataTask *)inputValidateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];

    NSString *url = Regist_url;
    
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
       return [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
    
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
        
        if (block) {
            block([NSDictionary dictionary],nil);
        }
    }];
  }

#pragma mark --头像上传
+ (NSURLSessionDataTask *)upPhotoWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSString *url = UpHeadImage_url;
    
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    return [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
    
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
        
        if (block) {
            block([NSDictionary dictionary],nil);
        }
    }];
    
}

#pragma mark--我的订单
+ (NSURLSessionDataTask *)myOrderWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"sessionId"];
    NSLog(@"会话id为：%@",sessionId);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *session = @"5D1AC4544EA774BD20E527C38CB8BB33";
    NSString *detailedAduit = @"1";
   // NSString *url =[NSString stringWithFormat:@"http://192.168.2.103:8090/order/userorderbases/%@/%@",sessionId,detailedAduit];
    NSString *url =[NSString stringWithFormat:@"http://192.168.2.103:8090/order/userorderbases/%@/%@",session,detailedAduit];
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
  //  申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
  //  申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    return [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (block) {
                       block(responseObject,nil);
                   }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        
                if (block) {
                    block([NSDictionary dictionary],nil);
                 }
        
    }];
}
#pragma mark --验证码接口
+ (NSURLSessionDataTask *)validateCodeWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSString *url = Validate_url;
    
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    return [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
        
        if (block) {
            block([NSDictionary dictionary],nil);
        }
    }];
}
#pragma mark--订单详情
+ (NSURLSessionDataTask *)orderDetailWithBlock:(void (^)(NSDictionary *infoDic, NSError *error))block and:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置返回格式
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *orderBaseId  = @"1";
    NSString *url = [NSString stringWithFormat:@"http://192.168.2.103:8090/order/orderdetaileds/%@",orderBaseId];
   // NSString *url1 = OrderDetail_url;
    
    NSURL *urls = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    return [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        
        if (block) {
            block([NSDictionary dictionary],nil);
        }
        
    }];


}


@end
