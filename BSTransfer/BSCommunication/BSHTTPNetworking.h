//
//  BSHTTPNetworking.h
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSCMFrameworkHeader.h"
#import "LoginUser.h"

typedef void (^BSAFRequestSuccess)
    (AFHTTPRequestOperation *operation, id responseObject);

typedef void (^BSAFRequestFailure)
    (AFHTTPRequestOperation *operation, NSError *error);

typedef void (^BSHTTPRequestSuccess)
    (NSURLSessionDataTask *task, id responseObject, id model);

typedef void (^BSHTTPRequestFailure)(NSError *error);



@interface BSHTTPNetworking : NSObject

+(void)currentUser:(LoginUser *)user;

+(instancetype)httpManager;

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


- (void (^)(NSError *error))
    block:(BSHTTPResponse)block
    failure:(BSHTTPRequestFailure)failure
    errorUILabel:( UILabel *)errorUILabel;

@end
