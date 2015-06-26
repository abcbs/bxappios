//
//  ErrorMessage.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorMessage : NSObject

@property (nonatomic, copy) NSString *errorCode;

@property (nonatomic, copy) NSString *message;

- (instancetype)initWithDic:(NSDictionary *)dic;


+ (instancetype)initWith:(NSDictionary *)dic;
@end
