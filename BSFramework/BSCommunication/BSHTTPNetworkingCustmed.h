//
//  BSHTTPNetworkingCustmed.h
//  KTAPP
//
//  Created by admin on 15/6/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSHTTPNetworking.h"

@interface BSHTTPNetworkingCustmed : BSHTTPNetworking


+ (instancetype)manager;

- (instancetype)initWithManager;

+(instancetype)httpManager;


@end
