//
//  CustomerOrderDetailed.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomerOrderDetailed.h"

@implementation CustomerOrderDetailed

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
   [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_detailOrderNumber forKey:@"detailOrderNumber"];
    
    [aCoder encodeInteger:_customerOrderId  forKey:@"customerOrderId"];
    
    [aCoder encodeInteger:_businessOrderId  forKey:@"businessOrderId"];
    
    [aCoder encodeInteger:_businessProductId  forKey:@"businessProductId"];
    
    [aCoder encodeInteger:_userBaseId forKey:@"userBaseId"];
    
    [aCoder encodeFloat:_preferPrice forKey:@"preferPrice"];
    
    [aCoder encodeFloat:_salePrice forKey:@"salePrice"];
    
    [aCoder encodeInt:_numbers forKey:@"numbers"];

    [aCoder encodeFloat:_total forKey:@"total"];
    
    [aCoder encodeObject:_detailedAduit forKey:@"detailedAduit"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _id= [aDecoder decodeIntegerForKey:@"id"];
    
    _detailOrderNumber = [aDecoder decodeObjectForKey:@"detailOrderNumber"];
    
    _customerOrderId= [aDecoder decodeIntegerForKey:@"customerOrderId"];
    
    _businessOrderId= [aDecoder decodeIntegerForKey:@"businessOrderId"];
    
    _businessProductId= [aDecoder decodeIntegerForKey:@"businessProductId"];
    
    _userBaseId= [aDecoder decodeIntegerForKey:@"userBaseId"];
    
    _preferPrice= [aDecoder decodeFloatForKey:@"preferPrice"];
    
    _salePrice= [aDecoder decodeFloatForKey:@"salePrice"];
    
    _numbers=[aDecoder decodeIntForKey:@"numbers"];
    
    _total=[aDecoder decodeFloatForKey:@"total"];
    
    _detailedAduit= [aDecoder decodeObjectForKey:@"detailedAduit"];
    
   _status= [aDecoder decodeObjectForKey:@"status"];
    
    _updateTime= [aDecoder decodeObjectForKey:@"updateTime"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"客户订单详细\t%lid, :商品标示 %ld, 数量: %@ \t用户标示: %ld", (long)_id, (long)_businessProductId, _detailOrderNumber, (long)_userBaseId];
}
@end
