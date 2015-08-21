//
//  BSHTTPNetworking.h
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSCMFrameworkHeader.h"
/**
 * <returntype>(^blockname)(list of arguments)=^(arguments){body}
 *
 *
 */

typedef void (^BSAFRequestSuccess)
    (AFHTTPRequestOperation *operation, id responseObject);

typedef void (^BSAFRequestFailure)
    (AFHTTPRequestOperation *operation, NSError *error);

typedef void (^BSHTTPRequestSuccess)
    (NSURLSessionDataTask *task, id responseObject, id model);

typedef void (^BSHTTPRequestFailure)(NSError *error);



@interface BSHTTPNetworking : NSObject

+ (instancetype)manager;

- (instancetype)initWithManager;

+(instancetype)httpManager;



- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                            parameters:(id)parameters
                            success:(BSAFRequestSuccess)success
                            failure:(BSAFRequestFailure)failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                            parameters:(id)parameters
                            success:(BSAFRequestSuccess)success
                            failure:(BSAFRequestFailure)failure;

+(void)httpGET:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel;

+(void)httpGET:(NSString *)restPath
   pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
       keyPath:(NSString *)keyPath
         block:(BSHTTPResponse)block;
/**
 * Http Restful Get ,Data Model Descrited JMExtension
 */
-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel;

-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block;

+(void)httpPOST:(NSString *)restPath
        pathPattern:(NSString * )pathPattern
        parameters:(id)parameters
        modelClass:(Class)modelClass
        keyPath:(NSString *)keyPath
        block:(BSHTTPResponse)block
        errorUILabel:( UILabel *)errorUILabel;

+(void)httpPOST:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
     parameters:(id)parameters
     modelClass:(Class)modelClass
        keyPath:(NSString *)keyPath
          block:(BSHTTPResponse)block;

/**
 * Http Restful Post ,Data Model Descrited JMExtension
 */
-(void)post:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel;

-(void)post:(NSString *)restPath
pathPattern:(NSString * )pathPattern
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block;


- (void (^)(AFHTTPRequestOperation *operation, NSError *error))requestFailureBlockWithAFHTTPRequestOperation:(BSAFRequestSuccess)success
    failure:(BSAFRequestFailure)failure;

- (void (^)(NSError *error))
    block:(BSHTTPResponse)block
    failure:(BSHTTPRequestFailure)failure
    errorUILabel:( UILabel *)errorUILabel;

@end
