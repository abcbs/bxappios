//
//  Comment.m
//  民生小区
//
//  Created by LouJQ on 15-5-8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

@implementation Comment


- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.id = [[dic valueForKeyPath:@"id"] intValue];
    self.username = [dic valueForKeyPath:@"username"];
    self.comment = [dic valueForKeyPath:@"comment"];
    
    return self;
}
+ (instancetype)commentWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
@end
