//
//  orderDetailOneModel.m
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "orderDetailOneModel.h"

@implementation orderDetailOneModel
@synthesize address = _address;
@synthesize contractname = _contractname;
@synthesize id = _id;
@synthesize businessName = _businessName;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}
+ (instancetype)myOrderDetailWithDic:(NSDictionary *)dic{
   return [[self alloc] initWithDic:dic];
}

@end
