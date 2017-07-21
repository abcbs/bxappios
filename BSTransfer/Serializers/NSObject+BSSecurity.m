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
#import "BSIFTTHeader.h"
#import "BSSecurityConfig.h"
#import "BSIFTTHeader.h"
#import "LBModelsHeader.h"

#import <objc/runtime.h>

@implementation NSObject (BSSecurity)

#pragma mark - --常用的对象--
static NSNumberFormatter *_numberFormatter;
static  NSMutableArray * _securityConfigs;
static BSSecurity *security;
+ (void)load
{
    _numberFormatter = [[NSNumberFormatter alloc] init];
    
    security=[BSSecurityFactory initBSecurity:BSEncryptionAlgorithmRSA];
    
    _securityConfigs=[NSMutableArray array];
    
    
    
    BSSecurityConfig *config=[BSSecurityConfig initWithClass:[LoginUser class]];
    
    [config addBSSecurityField:@"username" crptyType:1];
    //
    [_securityConfigs addObject:config];
    
    config=[BSSecurityConfig initWithClass:[UserSession class]];
    
    [config addBSSecurityField:@"username" crptyType:2];
    //
    [_securityConfigs addObject:config];
    
    
}

-(id)encrypt{
    return [self encryptOrDecryptData:1];
}

- (id)decrypt{
    return [self encryptOrDecryptData:2];
}
- (id)encryptOrDecryptData:(int) cryptType {
    // 如果自己不是模型类
    if ([MJFoundation isClassFromFoundation:[self class]]) return (NSMutableDictionary *)self;
    /*
    @try {
        Class aClass = [self class];
        NSArray *allowedPropertyNames = [aClass totalAllowedPropertyNames];
        
        [aClass enumerateProperties:^(MJProperty *property, BOOL *stop) {
            // 0.检测是否被忽略
            if (allowedPropertyNames.count && ![allowedPropertyNames containsObject:property.name]) return;
            
            // 1.取出属性值
            id value = [property valueForObject:self];
            if (!value) return;
            
            // 2.如果是模型属性，在加解密协议中需要对类型
            MJType *type = property.type;
            Class typeClass = type.typeClass;
            Class objectClass = [property objectClassInArrayFromClass:[self class]];
            if (!type.isFromFoundation && typeClass) {
                value = [typeClass objectWithKeyValues:value context:nil error:nil];
            } else if (objectClass) {
                // 3.字典数组-->模型数组
                value = [objectClass objectArrayWithKeyValuesArray:value context:nil error:nil];
            } else if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    // NSNumber -> NSString
                    value = [value description];
                } else if ([value isKindOfClass:[NSURL class]]) {
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
                //解密
                [self decryptOrdecrypt:property value:value
                                  type:cryptType];
            } else if ([value isKindOfClass:[NSString class]]) {
                if (typeClass == [NSURL class]) {
                    // NSString -> NSURL
                    // 字符串转码
                    value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)value,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
                    value = [NSURL URLWithString:value];
                } else if (type.isNumberType) {
                    NSString *oldValue = value;
                    
                    // NSString -> NSNumber
                    value = [_numberFormatter numberFromString:oldValue];
                    
                    // 如果是BOOL
                    if (type.isBoolType) {
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
               [self decryptOrdecrypt:property value:value
                                type:cryptType];
            }
            // 4.赋值
           
        }];
       
    } @catch (NSException *exception) {
        BSLog(@"加解密失败，\t%@",exception.description);
    }
     */
    return self;
}

-(void)decryptOrdecrypt:(MJProperty *)property value:(NSString *)value type:(int)type{
    //NSString *key = @"introduce";
    BSSecurityField *securityField=[self decryptOrdecryptField:property.name ];
    if ([property.name isEqualToString:securityField.fieldName]) {
        if (type==1 && (securityField.type==1||securityField.type==3)) {//请求
            NSString *encrAcc=[security encryptString:value];
            
            [property setValue:encrAcc forObject:self];
        }else if (type==2 && (securityField.type==2||securityField.type==3)){
             NSString *encrAcc=[security decryptString:value];
            [property setValue:encrAcc forObject:self];
        }
       
    }
    
}


-(BSSecurityField *)decryptOrdecryptField:( NSString *)field{
    Class aClass = [self class];
    for (BSSecurityConfig *config in _securityConfigs) {
        if ([config.clzz isSubclassOfClass: aClass]) {
            for (BSSecurityField *securityField in config.fields){
                if (securityField) {
                    if ([securityField.fieldName isEqualToString:field]){
                        return securityField;
                    }
                }
            }
        }
    }
    
    return nil;
}
@end
