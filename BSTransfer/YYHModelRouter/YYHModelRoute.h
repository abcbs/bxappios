//
//  YYHModelRoute.h
//  YYHModelRouter
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHModelRoute : NSObject

@property (nonatomic, copy, readonly) NSString *keyPath;
@property (nonatomic, weak, readonly) Class modelClass;
@property (nonatomic, copy, readonly) NSString *requestMethod;

+ (instancetype)GETRouteWithModelClass:(Class)modelClass
                               keyPath:(NSString *)keyPath;
+ (instancetype)POSTRouteWithModelClass:(Class)modelClass
                                keyPath:(NSString *)keyPath;
+ (instancetype)PUTRouteWithModelClass:(Class)modelClass
                               keyPath:(NSString *)keyPath;
+ (instancetype)DELETERouteWithModelClass:(Class)modelClass
                                  keyPath:(NSString *)keyPath;

+ (NSString *)getRequestMethod;
+ (NSString *)postRequestMethod;
+ (NSString *)putRequestMethod;
+ (NSString *)deleteRequestMethod;

@end
