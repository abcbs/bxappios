//
//  BSHTTPNetworking.h
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ErrorMessage.h"

@interface BSHTTPNetworking : NSObject

+ (instancetype)manager;

- (instancetype)initWithManager;

+(instancetype)httpManager;

- (instancetype)initWithBaseURL:(NSURL *)url;


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 * Http Restful Get ,Data Model Descrited JMExtension
 */
-(void)get:(NSString *)restPath pathPattern:(NSString * )pathPattern 
     modelClass:(Class)modelClass keyPath:(NSString *)keyPath
     block:(void (^)(NSMutableArray *waters,
           NSError *error,ErrorMessage *bsErrorMessage))block;


@end
