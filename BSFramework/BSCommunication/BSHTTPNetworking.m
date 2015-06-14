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

#import <Availability.h>
@interface BSHTTPNetworking ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *bsmanager;


@end

@implementation BSHTTPNetworking

@synthesize bsmanager;



+ (instancetype)manager {
    return [[self alloc] initWithManager:nil];
}

- (instancetype)init {
    return [self initWithManager:nil];
}

- (instancetype)initWithManager:(AFHTTPRequestOperationManager *)manager
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
