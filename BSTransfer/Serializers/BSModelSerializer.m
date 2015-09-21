//
//
//  Copyright (c) 2015年 KT. All rights reserved.
//  在HTTP请求的Response和Resquest中增加加密解密内容
//

#import "BSModelSerializer.h"
#import "MJExtension.h"
#import "BSUIFrameworkHeader.h"
#import "BSIFTTHeader.h"
#import "LBModelsHeader.h"
#import "NSObject+BSSecurity.h"

@interface BSModelSerializer(){
    BSSecurity *security;
}
@end
@implementation BSModelSerializer

static NSNumberFormatter *_numberFormatter;

-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    security=[BSSecurityFactory initBSecurity:BSEncryptionAlgorithmRSA];
    return self;
}
#pragma mark - YYHModelSerialization

- (id)modelForJSONDictionary:(NSDictionary *)jsonDictionary modelClass:(Class)modelClass error:(NSError *__autoreleasing *)error {
    //增加加解密处理
    //Ivar object_setInstanceVariable ( id obj, const char *name, void *value );
    id object=[modelClass objectWithKeyValues:jsonDictionary ];
    return object;
}

- (id)modelsForJSONArray:(NSArray *)jsonArray modelClass:(Class)modelClass error:(NSError *__autoreleasing *)error {
    id object=[ modelClass objectWithKeyValues:jsonArray ];

    return object;
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
    id keyValuesArray= [ modelClass objectArrayWithKeyValuesArray:jsonArray ];
    //
    NSMutableArray *modelArray = [NSMutableArray array];
    // 3.遍历 配置方法 LiuJQ
    for (NSDictionary *keyValues in keyValuesArray) {
         //安全配置处理
         [modelArray addObject:[keyValues encrypt:modelClass]];
    }
    
    return modelArray;
}

/**
 *请求加密处理，
 */
- (NSDictionary *)jsonDictionaryForModel:(NSObject *)object modelClass:(Class)modelClass error:(NSError **)error{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)object;
    }
    //加解密处理
    if ([modelClass isSubclassOfClass:[LoginUser class]]) {
        LoginUser *objResponse= (LoginUser *)object;
        NSString *encrAcc=[security encryptString:objResponse.username];
        [objResponse setValue:encrAcc forKey:@"username"];
        NSDictionary * dic=[object keyValues];
        return dic;
    }
    return nil;
}
@end
