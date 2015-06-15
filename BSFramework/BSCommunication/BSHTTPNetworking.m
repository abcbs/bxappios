//
//  BSHTTPNetworking.m
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BSHTTPNetworking.h"
#import "AFNetworking.h"
#import "YYHModelRouter.h"
#import "Conf.h"
#import "ErrorMessage.h"

@interface BSHTTPNetworking ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *bsmanager;

@property (nonatomic, strong) YYHModelRouter *router;

@end

@implementation BSHTTPNetworking

@synthesize bsmanager;

@synthesize router;



+ (instancetype)manager {
    return [[self alloc] initWithManager];
}



+(instancetype)httpManager
{
    return [[self alloc] initWithBaseURL];
}

- (instancetype)initWithBaseURL{
    self = [super init];
    if (!self) {
        return nil;
    }
    if(!self.router) {
        self.router=  [[YYHModelRouter alloc]
                       initWithBaseURL:[NSURL URLWithString:[Conf urlBase]]];
    }
    return self;
}



-(void)get:(NSString *)restPath pathPattern:(NSString * )pathPattern
modelClass:(Class)modelClass keyPath:(NSString *)keyPath
     block:(void (^)(NSMutableArray *waters
                     , NSError *error,ErrorMessage *bsErrorMessage))block
{
    
    [BSHTTPNetworking httpManager];
    
    [router routeGET:pathPattern modelClass:[modelClass class] keyPath:keyPath];
    
    [router GET:restPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject, id model) {
        if (block&&![model isKindOfClass:[ErrorMessage class]]) {
            block([NSMutableArray arrayWithArray:model],nil,nil);
        }else if(block&& [model isKindOfClass:[ErrorMessage class]]){
             block(nil,nil,model);
        }
    }
     
    failure:^(NSError *error) {
        if (block) {
            block(nil,error,nil);
        }
        
    }];

}

- (instancetype)initWithManager
{
    self = [super init];
    if (!self) {
        return nil;
    }
    if(!self.bsmanager) {
       self.bsmanager= [AFHTTPRequestOperationManager manager];
    }
    return self;

}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    return [bsmanager GET:URLString parameters:parameters
                  success:success failure:failure];
    
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    //申明返回的结果是json类型
    bsmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    bsmanager.requestSerializer=[AFJSONRequestSerializer serializer];
    return [bsmanager POST:URLString
                parameters:parameters
                   success:success
                   failure:failure
            ];
}

@end
