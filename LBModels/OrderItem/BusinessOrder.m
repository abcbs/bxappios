//
//  BusinessOrder.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessOrder.h"

@implementation BusinessOrder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_orderNumber forKey:@"orderNumber"];

    [aCoder encodeInteger:_orderBaseId forKey:@"orderBaseId"];
    
    [aCoder encodeInteger:_businessId forKey:@"businessId"];
    
    [aCoder encodeObject:_orderNumber forKey:@"orderNumber"];

    [aCoder encodeInteger:_count forKey:@"count"];
    
    [aCoder encodeFloat:_totalCash forKey:@"totalCash"];

    [aCoder encodeObject:_detailedAduit forKey:@"detailedAduit"];
    
    [aCoder encodeObject:_status forKey:@"status"];

    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
      
    _id= [aDecoder decodeIntegerForKey:@"id"];
    
    _orderBaseId= [aDecoder decodeIntegerForKey:@"orderBaseId"];
    
    _businessId= [aDecoder decodeIntegerForKey:@"businessId"];
    
    _orderNumber=[aDecoder decodeObjectForKey:@"orderNumber"];
    
    _count= [aDecoder decodeIntegerForKey:@"count"];
    
    _totalCash= [aDecoder decodeFloatForKey:@"totalCash"];
    
    _detailedAduit=[aDecoder decodeObjectForKey:@"detailedAduit"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];

    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家订单\t%lid, :基础订单ID %ld, 产品ID: %ld \t总数量: %ld", (long)_id, (long)_orderBaseId, (long)_businessId, (long)_count];
}

@end
