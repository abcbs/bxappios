//
//  BSSecurityConfig.m
//  KTAPP
//
//  Created by admin on 15/9/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSSecurityConfig.h"
@implementation BSSecurityField : NSObject
@synthesize fieldName=_fieldName;
@synthesize type=_type;
@end

@implementation BSSecurityConfig
@synthesize fields=_fields;
@synthesize clzz=_clzz;
+(instancetype)initWithClass:(Class)clzz
{
    return [[super alloc] initWithClass:clzz];
}

-(instancetype)initWithClass:(Class)clzz{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.clzz=clzz;
    self.fields=[NSMutableArray array];
    return self;
}

-(void)addBSSecurityField:(BSSecurityField *) securityField{
    [self.fields addObject:securityField];
}

-(void)addBSSecurityField:(NSString *) securityField crptyType:(int)crptyType{
    BSSecurityField *sField=[[BSSecurityField alloc]init];
    sField.type=crptyType;
    sField.fieldName=securityField;
    [self addBSSecurityField:sField];
}
@end
