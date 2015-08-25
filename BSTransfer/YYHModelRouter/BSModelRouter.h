//
//  YYHModelRouter.h
//  YYHModelRouter
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSModelSerialization.h"

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^YYHModelRequestSuccess)(NSURLSessionDataTask *task, id responseObject, id model);
typedef void (^YYHModelRequestFailure)(NSError *error);

@interface BSModelRouter : NSObject

@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;
@property (nonatomic, retain) id<BSModelSerialization> modelSerializer;
@property (nonatomic, strong) NSString *netStatus;

/**
 Initialize a model router with a base URL.
 */
- (instancetype)initWithBaseURL:(NSURL *)url;
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration;
/**
 Add a route for a GET request.
 @param pathPattern Request path pattern.
 @param modelClass Class of model to load for this route.
 @param keyPath Key path of JSON value used to serialize model.
 */
- (void)routeGET:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath;

/**
 Add a route for a POST request.
 @param pathPattern Request path pattern.
 @param modelClass Class of model to load for this route.
 @param keyPath Key path of JSON value used to serialize model.
 */
- (void)routePOST:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath;

/**
 Add a route for a PUT request.
 @param pathPattern Request path pattern.
 @param modelClass Class of model to load for this route.
 @param keyPath Key path of JSON value used to serialize model.
 */
- (void)routePUT:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath;

/**
 Add a route for a DELETE request.
 @param pathPattern Request path pattern.
 @param modelClass Class of model to load for this route.
 @param keyPath Key path of JSON value used to serialize model.
 */
- (void)routeDELETE:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath;

/**
 Send a GET request and serialize the response as a model object.
 */
- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure;

/**
 Send a POST request and serialize the response as a model object.
 */
- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure;

/**
 Send a PUT request and serialize the response as a model object.
 */
- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure;

/**
 Send a DELETE request and serialize the response as a model object.
 */
- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure;

- (NSString *)requestPathForModelPath:(NSString *)modelPath;

- (id)serializedModelForResponseObject:(id)responseObject modelClass:(Class)modelClass error:(NSError **)error;

@end
