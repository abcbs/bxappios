//
//  Comment.h
//  民生小区
//
//  Created by LouJQ on 15-5-8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import "MJExtension.h"

@interface Comment : NSObject

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) int id;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)commentWithDic:(NSDictionary *)dic;

@end
