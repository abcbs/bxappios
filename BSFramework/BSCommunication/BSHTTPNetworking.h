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

typedef void (^BSHTTPRequestSuccess)(AFHTTPRequestOperation *operation, id responseObject);

typedef void (^BSHTTPRequestFailure)(AFHTTPRequestOperation *operation, NSError *error);


@interface BSHTTPNetworking : NSObject

+ (instancetype)manager;

- (instancetype)initWithManager;

+(instancetype)httpManager;



- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(BSHTTPRequestSuccess)success
                        failure:(BSHTTPRequestFailure)failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(BSHTTPRequestSuccess)success
                         failure:(BSHTTPRequestFailure)failure;

+(void)httpGET:(NSString *)restPath pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass keyPath:(NSString *)keyPath
         block:(void (^)(NSObject *response,
                         NSError *error,ErrorMessage *bsErrorMessage))block;

/**
 * Http Restful Get ,Data Model Descrited JMExtension
 */
-(void)get:(NSString *)restPath pathPattern:(NSString * )pathPattern
     modelClass:(Class)modelClass keyPath:(NSString *)keyPath
     block:(void (^)(NSObject *response,
           NSError *error,ErrorMessage *bsErrorMessage))block;


+(void)httpPOST:(NSString *)restPath pathPattern:(NSString * )pathPattern
     parameters:(id)parameters
     modelClass:(Class)modelClass keyPath:(NSString *)keyPath
         block:(void (^)(NSObject *response,
                         NSError *error,ErrorMessage *bsErrorMessage))block;

/**
 * Http Restful Post ,Data Model Descrited JMExtension
 */
-(void)post:(NSString *)restPath pathPattern:(NSString * )pathPattern
 parameters:(id)parameters
 modelClass:(Class)modelClass keyPath:(NSString *)keyPath
     block:(void (^)(NSObject *response,
                     NSError *error,ErrorMessage *bsErrorMessage))block;
@end
