//
//  ErrorMessage.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ErrorMessage.h"
@implementation ErrorMessage

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)initWith:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

-(NSString *)description

{
    return [NSString stringWithFormat:@"错误信息，编码: %@ 错误信息: %@",
            self.errorCode,self.message];
    
}
@end
