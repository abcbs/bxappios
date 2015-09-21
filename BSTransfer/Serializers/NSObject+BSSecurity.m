//
//  NSObject+BSSecurity.m
//  KTAPP
//
//  Created by admin on 15/9/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NSObject+BSSecurity.h"
#import "NSObject+MJKeyValue.h"
#import "NSObject+MJProperty.h"
#import "MJProperty.h"
#import "MJType.h"
#import "MJConst.h"
#import "MJFoundation.h"

#import <objc/runtime.h>

@implementation NSObject (BSSecurity)

#pragma mark - --常用的对象--
static NSNumberFormatter *_numberFormatter;
+ (void)load
{
    _numberFormatter = [[NSNumberFormatter alloc] init];
}

- (id)encrypt:(Class)modelClass {
    // 如果自己不是模型类
    if ([MJFoundation isClassFromFoundation:[self class]]) return (NSMutableDictionary *)self;
    
    id keyValues = [NSMutableDictionary dictionary];
    
    @try {
        Class aClass = [self class];
        NSArray *allowedPropertyNames = [aClass totalAllowedPropertyNames];
        //NSArray *ignoredPropertyNames = [aClass totalIgnoredPropertyNames];
        
        [aClass enumerateProperties:^(MJProperty *property, BOOL *stop) {
            // 0.检测是否被忽略
            if (allowedPropertyNames.count && ![allowedPropertyNames containsObject:property.name]) return;
            
            // 1.取出属性值
            id value = [property valueForObject:self];
            if (!value) return;
            
            // 2.如果是模型属性
            MJType *type = property.type;
            Class typeClass = type.typeClass;
            if (!type.isFromFoundation && typeClass) {
                value = [value keyValues];
            } else if ([value isKindOfClass:[NSArray class]]) {
                // 3.处理数组里面有模型的情况
                value = [NSObject keyValuesArrayWithObjectArray:value];
            } else if (typeClass == [NSURL class]) {
                value = [value absoluteString];
            }
            
            keyValues[property.name] = value;
            
        }];
        
        // 去除系统自动增加的元素
        if ([keyValues isKindOfClass:[NSMutableDictionary class]]) {
            [keyValues removeObjectsForKeys:@[@"superclass", @"debugDescription", @"description", @"hash"]];
        }
        
    } @catch (NSException *exception) {
       // MJBuildError(error, exception.reason);
    }
    
    return self;
}

- (id)encrypt:(Class)modelClass context:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error{
    return nil;
}
@end
