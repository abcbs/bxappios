//
//  YYHModelRouter.m
//  YYHModelRouter
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "YYHModelRouter.h"
#import "YYHModelRoute.h"
#import "YYHMantleModelSerializer.h"
#import "ErrorMessage.h"
#import "MJExtension.h"
#import "AFNetworking.h"

#if defined(__has_include)
#if __has_include("MJExtension.h")
#define HAS_MANTLE YES



#endif
#endif

const NSInteger YYHModelRouterErrorSerialization = 1;
NSString * const YYHModelRouterErrorDomain = @"com.yayuhh.YYHModelRouterError";

@interface YYHModelRouteGroup : NSObject

@property (nonatomic, strong) YYHModelRoute *getRoute;
@property (nonatomic, strong) YYHModelRoute *postRoute;
@property (nonatomic, strong) YYHModelRoute *putRoute;
@property (nonatomic, strong) YYHModelRoute *deleteRoute;

- (YYHModelRoute *)routeForRequestMethod:(NSString *)requestMethod;

@end

@implementation YYHModelRouteGroup

- (YYHModelRoute *)routeForRequestMethod:(NSString *)requestMethod {
    if ([requestMethod isEqualToString:[YYHModelRoute getRequestMethod]]) {
        return self.getRoute;
    } else if ([requestMethod isEqualToString:[YYHModelRoute postRequestMethod]]) {
        return self.postRoute;
    } else if ([requestMethod isEqualToString:[YYHModelRoute putRequestMethod]]) {
        return self.putRoute;
    } else if ([requestMethod isEqualToString:[YYHModelRoute deleteRequestMethod]]) {
        return self.deleteRoute;
    }
    return nil;
}

@end

@interface YYHModelRouter ()

@property (nonatomic, strong, readwrite) NSURL *baseURL;
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *routeMap;

@end

@implementation YYHModelRouter
@synthesize netStatus;

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)url {
    if ((self = [super init])) {
        _baseURL = url;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:_baseURL];
        
        _sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        _sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
        [_sessionManager.reachabilityManager
            setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"目前网络状态WWAN");
                    netStatus=@"WAN";
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"目前网络为WiFi");
                    netStatus=@"WiFi";
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"目前没有网络环境");
                    netStatus=@"NoNet";
                    break;
                default:
                    break;
            }
        }];
        
        [_sessionManager.reachabilityManager startMonitoring];
#ifdef HAS_MANTLE
        _modelSerializer = [[YYHMantleModelSerializer alloc] init];
#endif
    }
    
    return self;
}

#pragma mark - Routing Internals

- (NSMutableDictionary *)routeMap {
    if (!_routeMap) {
        _routeMap = [[NSMutableDictionary alloc] init];
    }

    return _routeMap;
}

- (YYHModelRouteGroup *)routeGroupForPathPattern:(NSString *)pathPattern {
    YYHModelRouteGroup *group = self.routeMap[pathPattern];
    
    if (!group) {
        group = [[YYHModelRouteGroup alloc] init];
        self.routeMap[pathPattern] = group;
    }
    
    return group;
}

- (YYHModelRouteGroup *)routeGroupForPath:(NSString *)path {
    for (NSString *testPathPattern in self.routeMap) {
        if ([self pathPattern:testPathPattern matchesPath:path]) {
            return self.routeMap[testPathPattern];
        }
    }
    
    return nil;
}

- (YYHModelRoute *)modelRouteForPath:(NSString *)path method:(NSString *)method {
    YYHModelRouteGroup *routeGroup = [self routeGroupForPath:path];
    return [routeGroup routeForRequestMethod:method];
}

#pragma mark - Path Matching

- (BOOL)pathPattern:(NSString *)pathPattern matchesPath:(NSString *)path {
    return [self pathComponents:[pathPattern componentsSeparatedByString:@"/"]
            matchPathComponents:[path componentsSeparatedByString:@"/"]];
}

- (BOOL)pathComponents:(NSArray *)matchingComponents matchPathComponents:(NSArray *)pathComponents {
    if (matchingComponents.count == pathComponents.count) {
        NSUInteger index = 0;
        for (NSString *testComponent in matchingComponents) {
            if (![self pathComponent:testComponent matchesPathComponent:pathComponents[index]]) {
                return NO;
            }
            index++;
        }
        return YES;
    }
    return NO;
}

- (BOOL)pathComponent:(NSString *)pathComponent matchesPathComponent:(NSString *)testComponent {
    if (![pathComponent isEqualToString:testComponent]) {
        if (![pathComponent hasPrefix:@":"] && ![testComponent hasPrefix:@":"]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Routing API

- (void)routeGET:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath {
    [self routeGroupForPathPattern:pathPattern].getRoute = [YYHModelRoute GETRouteWithModelClass:modelClass keyPath:keyPath];
}

- (void)routePOST:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath {
    [self routeGroupForPathPattern:pathPattern].postRoute = [YYHModelRoute POSTRouteWithModelClass:modelClass keyPath:keyPath];
}

- (void)routePUT:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath {
    [self routeGroupForPathPattern:pathPattern].putRoute = [YYHModelRoute PUTRouteWithModelClass:modelClass keyPath:keyPath];
}

- (void)routeDELETE:(NSString * )pathPattern modelClass:(Class)modelClass keyPath:(NSString *)keyPath {
    [self routeGroupForPathPattern:pathPattern].deleteRoute = [YYHModelRoute DELETERouteWithModelClass:modelClass keyPath:keyPath];
}

#pragma mark - Model Request API

- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure {
    YYHModelRoute *modelRoute = [self modelRouteForPath:path method:[YYHModelRoute getRequestMethod]];
    NSAssert(modelRoute != nil, @"Could not find modelRoute for path \"%@\"", path);
    
    [self.sessionManager GET:[self requestPathForModelPath:path]
                  parameters:parameters
                     success:[self requestSuccessBlockWithModelRoute:modelRoute success:success failure:failure]
                     failure:[self requestFailureBlockWithModelRoute:modelRoute success:success failure:failure]];
}

- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure {
    YYHModelRoute *modelRoute = [self modelRouteForPath:path method:[YYHModelRoute postRequestMethod]];
    NSAssert(modelRoute != nil, @"Could not find modelRoute for path \"%@\"", path);
  
    
    [self.sessionManager POST:[self requestPathForModelPath:path]
                  parameters:parameters
                     success:[self requestSuccessBlockWithModelRoute:modelRoute success:success failure:failure]
                     failure:[self requestFailureBlockWithModelRoute:modelRoute success:success failure:failure]];
}

- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure {
    YYHModelRoute *modelRoute = [self modelRouteForPath:path method:[YYHModelRoute putRequestMethod]];
    NSAssert(modelRoute != nil, @"Could not find modelRoute for path \"%@\"", path);
    
    [self.sessionManager PUT:[self requestPathForModelPath:path]
                   parameters:parameters
                      success:[self requestSuccessBlockWithModelRoute:modelRoute success:success failure:failure]
                      failure:[self requestFailureBlockWithModelRoute:modelRoute success:success failure:failure]];
}

- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters success:(YYHModelRequestSuccess)success failure:(YYHModelRequestFailure)failure {
    YYHModelRoute *modelRoute = [self modelRouteForPath:path method:[YYHModelRoute deleteRequestMethod]];
    NSAssert(modelRoute != nil, @"Could not find modelRoute for path \"%@\"", path);
    
    [self.sessionManager DELETE:[self requestPathForModelPath:path]
                     parameters:parameters
                        success:[self requestSuccessBlockWithModelRoute:modelRoute success:success failure:failure]
                        failure:[self requestFailureBlockWithModelRoute:modelRoute success:success failure:failure]];
}

#pragma mark - Request Handlers

- (void (^)(NSURLSessionDataTask *task, id responseObject))requestSuccessBlockWithModelRoute:(YYHModelRoute *)modelRoute
                                                                                     success:(YYHModelRequestSuccess)success
                                                                                     failure:(YYHModelRequestFailure)failure {
    return ^(NSURLSessionDataTask *task, id responseObject) {
        NSError *serializationError = nil;
        //检查返回的是否为业务异常数据
        //[ErrorMessage class] keyPath:@"responseHeader"];
        NSObject *businessError = [responseObject valueForKeyPath:@"responseHeader"];
        
        ErrorMessage  *businessErrorModel= [self serializedModelForResponseObject:businessError modelClass:[ErrorMessage class] error:&serializationError];
        
        if (serializationError && failure) {
            failure(serializationError);
        }
        //业务处理成功
        if ([[businessErrorModel errorCode] isEqualToString:@"0000"]) {
            //处理ResponseBody
            NSObject *bussinessObject= [responseObject
                                        valueForKeyPath:@"responseBody"];
            //
            NSLog(@"本次请求返回经过转换的信息为\n%@",bussinessObject);
            if(bussinessObject !=nil){
        
                id model = [self serializedModelForResponseObject:bussinessObject modelClass:modelRoute.modelClass error:&serializationError];
           
                if (serializationError && failure) {
                    failure(serializationError);
                }
            
                if (success && model) {
                    success(task, responseObject, model);
                }
            }
            //
        }else if(success && businessErrorModel){
            success(task, businessError, businessErrorModel);
        }else if (failure) {
            
            failure(serializationError);
        }
        
    };
}

- (void (^)(NSURLSessionDataTask *task, NSError *error))requestFailureBlockWithModelRoute:(YYHModelRoute *)modelRoute
                                                                                  success:(YYHModelRequestSuccess)success
                                                                                  failure:(YYHModelRequestFailure)failure {
    return ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    };
}

#pragma mark - Serialization

- (id)serializedModelForResponseObject:(id)responseObject modelClass:(Class)modelClass error:(NSError **)error {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        return [self serializedModelForJSONDictionary:responseObject modelClass:modelClass error:error];
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        return [self serializedModelsForJSONArray:responseObject
                                       modelClass:modelClass ];
    }else  if ([responseObject isKindOfClass:[NSObject class]]) {
        return [self serializedModelsForJSONObject:responseObject
                                        modelClass:modelClass];
    }else{
        //如果没有转换成功则返回原生的响应
        return responseObject;
    }
}

- (id)serializedModelsForJSONObject:(NSObject *)responseObject modelClass:(Class)modelClass {
    if (self.modelSerializer) {
        return [self.modelSerializer
                objectWithKeyValue:responseObject
                modelClass:modelClass];
    } else {
        return responseObject;
    }
}

- (id)serializedModelForJSONDictionary:(NSDictionary *)jsonDictionary modelClass:(Class)modelClass error:(NSError **)error {
    if (self.modelSerializer) {
        return [self.modelSerializer modelForJSONDictionary:jsonDictionary modelClass:modelClass error:error];
    } else {
        return jsonDictionary;
    }
}

- (id)serializedModelsForJSONArray:(NSArray *)jsonArray modelClass:(Class)modelClass {
    if (self.modelSerializer) {
        return [self.modelSerializer
                objectArrayWithKeyValuesArray:jsonArray
                modelClass:modelClass];
    } else {
        return jsonArray;
    }
}

#pragma mark - Paths

- (NSString *)requestPathForModelPath:(NSString *)modelPath {
    return modelPath;
}

@end
