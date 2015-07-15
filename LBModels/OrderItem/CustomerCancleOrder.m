//
//  CustomerCancleOrder.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomerCancleOrder.h"

@implementation CustomerCancleOrder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_comment forKey:@"comment"];
    
    [aCoder encodeInteger:_businessProductId forKey:@"businessProductId"];
    
    [aCoder encodeInteger:_businessId forKey:@"businessId"];
    
    [aCoder encodeObject:_comment forKey:@"comment"];
    
    [aCoder encodeObject:_comment forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _id=[aDecoder decodeIntegerForKey:@"id"];
    
    _businessProductId=[aDecoder decodeIntegerForKey:@"businessProductId"];
    
    _businessId=[aDecoder decodeIntegerForKey:@"businessId"];
    
    _comment=[aDecoder decodeObjectForKey:@"comment"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"客户取消订单\t%lid, :商品标示 %ld, 取消原因: %@ \t产品名称: %@", (long)_id, (long)_businessProductId, _businessId, _comment];
}
@end
