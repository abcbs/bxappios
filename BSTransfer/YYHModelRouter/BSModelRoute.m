//
//  YYHModelRoute.m
//  YYHModelRouter
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSModelRoute.h"

NSString * const YYHModelRouteMethodGET = @"get";
NSString * const YYHModelRouteMethodPOST = @"post";
NSString * const YYHModelRouteMethodPUT = @"put";
NSString * const YYHModelRouteMethodDELETE = @"delete";

@implementation BSModelRoute

#pragma mark - Public API

+ (instancetype)GETRouteWithModelClass:(Class)modelClass
                               keyPath:(NSString *)keyPath {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath requestMethod:YYHModelRouteMethodGET];
}

+ (instancetype)POSTRouteWithModelClass:(Class)modelClass
                                keyPath:(NSString *)keyPath {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath requestMethod:YYHModelRouteMethodPOST];
}

+ (instancetype)PUTRouteWithModelClass:(Class)modelClass
                               keyPath:(NSString *)keyPath {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath requestMethod:YYHModelRouteMethodPUT];
}

+ (instancetype)DELETERouteWithModelClass:(Class)modelClass
                                  keyPath:(NSString *)keyPath {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath requestMethod:YYHModelRouteMethodDELETE];
}

+ (instancetype)modelRouteWithModelClass:(Class)modelClass
                                 keyPath:(NSString *)keyPath {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath];
}

+ (instancetype)modelRouteWithModelClass:(Class)modelClass
                                 keyPath:(NSString *)keyPath
                           requestMethod:(NSString *)requestMethod {
    return [[BSModelRoute alloc] initWithModelClass:modelClass keyPath:keyPath requestMethod:requestMethod];
}


- (instancetype)initWithModelClass:(Class)modelClass
                           keyPath:(NSString *)keyPath {
    return [self initWithModelClass:modelClass keyPath:keyPath requestMethod:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass
                           keyPath:(NSString *)keyPath
                     requestMethod:(NSString *)requestMethod {
    if ((self = [super init])) {
        _modelClass = modelClass;
        _keyPath = keyPath;
        _requestMethod = requestMethod != nil ? [requestMethod lowercaseString] : [BSModelRoute getRequestMethod];
    }
    
    return self;
}

+ (NSString *)getRequestMethod {
    return YYHModelRouteMethodGET;
}

+ (NSString *)postRequestMethod {
    return YYHModelRouteMethodPOST;
}

+ (NSString *)putRequestMethod {
    return YYHModelRouteMethodPUT;
}

+ (NSString *)deleteRequestMethod {
    return YYHModelRouteMethodDELETE;
}

@end
