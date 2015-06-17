//
//  BSHTTPNetworkingCustmed.m
//  KTAPP
//
//  Created by admin on 15/6/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSHTTPNetworkingCustmed.h"

@implementation BSHTTPNetworkingCustmed

+ (instancetype)manager {
    return [[super alloc] initWithManager];
}



+(instancetype)httpManager
{
    return [[super alloc] initWithBaseURL];
}


- (instancetype)initWithBaseURL{
    return [super initWithManager];
}

- (instancetype)initWithManager{
    return [super initWithManager];
}

- (void (^)(NSError *error))
    block:(BSHTTPResponse)block
    failure:(BSHTTPRequestFailure)failure
    errorUILabel:( UILabel *)errorUILabel
{
    return ^(NSError *error) {
        if (block) {
            block(nil,error,nil);
        }
    };
}

- (void (^)(AFHTTPRequestOperation *operation, NSError *error))requestFailureBlockWithAFHTTPRequestOperation:(BSAFRequestSuccess)success
                                                                                                     failure:(BSAFRequestFailure)failure
{
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
         }
    };
}

@end
