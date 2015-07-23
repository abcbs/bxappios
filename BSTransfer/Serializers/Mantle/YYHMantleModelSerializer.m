//
//  YYHMantleModelSerializer.m
//  YYHModelRouterExample
//
//  Created by Angelo Di Paolo on 11/28/14.
//  Copyright (c) 2014 Yayuhh. All rights reserved.
//

#import "YYHMantleModelSerializer.h"
#import "MJExtension.h"
//#import <Mantle/Mantle.h>


@implementation YYHMantleModelSerializer

static NSNumberFormatter *_numberFormatter;


#pragma mark - YYHModelSerialization

- (id)modelForJSONDictionary:(NSDictionary *)jsonDictionary modelClass:(Class)modelClass error:(NSError *__autoreleasing *)error {
    return [modelClass objectWithKeyValues:jsonDictionary ];
}

- (id)modelsForJSONArray:(NSArray *)jsonArray modelClass:(Class)modelClass error:(NSError *__autoreleasing *)error {
    return [ modelClass objectWithKeyValues:jsonArray ];
}
-(id)objectWithKeyValue:(NSObject *)responseObject
              modelClass:(Class)modelClass{
    id response=[self objectWithPrimaryKeyValue:responseObject
                                modelClass:modelClass];
    if (response) {
        return response;
    }else{
        return [modelClass objectWithKeyValues:responseObject];
    }
    return responseObject;
}

-(id) objectWithPrimaryKeyValue:(NSObject *)keyValues
                     modelClass:(Class)modelClass
{
    
    @try {
    id value = keyValues ;
    
    if (modelClass == [NSString class]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            // NSNumber -> NSString
            value = [value description];
        } else if ([value isKindOfClass:[NSURL class]]) {
            // NSURL -> NSString
            value = [value absoluteString];
        }
    } else if ([value isKindOfClass:[NSString class]]) {
        if (modelClass == [NSURL class]) {
            // NSString -> NSURL
            value = [NSURL URLWithString:value];
        } else if (modelClass==[NSNumber class]) {
            NSString *oldValue = value;
            if (_numberFormatter==nil) {
                _numberFormatter = [[NSNumberFormatter alloc] init];
            }            // NSString -> NSNumber
            value = [_numberFormatter numberFromString:oldValue];
            
            // 如果值是BOOL
            if ([value isBoolType] ) {
                // 字符串转BOOL（字符串没有charValue方法）
                // 系统会调用字符串的charValue转为BOOL类型
                NSString *lower = [oldValue lowercaseString];
                if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"]) {
                    value = @YES;
                } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                    value = @NO;
                }
            }
        }
    }
        return value;
    } @catch (NSException *exception) {
        return nil;
    }
   
}

- (id)objectArrayWithKeyValuesArray:(NSArray *)jsonArray
                         modelClass:(Class)modelClass
{
    return [ modelClass objectArrayWithKeyValuesArray:jsonArray ];
}
@end
