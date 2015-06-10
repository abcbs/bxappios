//
//  orderDetailModel.m
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "orderDetailModel.h"

@implementation orderDetailModel
@synthesize goodIntroduce = _goodIntroduce;
@synthesize salesPrice = _salesPrice;
@synthesize numbers = _numbers;
@synthesize total = _total;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}
+ (instancetype)myOrderDetailTwoWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
@end
