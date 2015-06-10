//
//  MyOrderModel.m
//  民生小区
//
//  Created by 闫青青 on 15/5/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyOrderModel.h"
#import "AFNHelp.h"
@implementation MyOrderModel
@synthesize orderNumber = _orderNumber;
@synthesize id = _id;
@synthesize totalCash = _totalCash;
@synthesize totalNumbers = _totalNumbers;
@synthesize updateTime = _updateTime;
@synthesize detailedAduit = _detailedAduit;
@synthesize status = _status;
@synthesize userBaseId = _userBaseId;

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

+ (instancetype)myOrderWithDic:(NSDictionary *)dic{
    //MyOrderModel *myOrderModel = [[MyOrderModel alloc]initWithDic:dic];
    //return self;
    return [[self alloc] initWithDic:dic];
}

@end
