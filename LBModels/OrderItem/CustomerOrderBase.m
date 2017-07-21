//
//  CustomerOrderBase.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomerOrderBase.h"

@implementation CustomerOrderBase

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_orderNumber forKey:@"orderNumber"];
    
    [aCoder encodeFloat:_totalCash forKey:@"totalCash"];
    
    [aCoder encodeInteger:_totalNumbers forKey:@"totalNumbers"];
    
    [aCoder encodeObject:_orderAduit forKey:@"orderAduit"];

    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeObject:_detailedAduit forKey:@"detailedAduit"];

    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeInteger:_userBaseId forKey:@"userBaseId"];

    [aCoder encodeInteger:_orderAddressId forKey:@"orderAddressId"];
    
    [aCoder encodeObject:_isInvoice forKey:@"isInvoice"];

    [aCoder encodeObject:_isClub forKey:@"isClub"];

    [aCoder encodeObject:_invoiceTitle forKey:@"invoiceTitle"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
     _id=[aDecoder decodeIntegerForKey:@"id"];
    
    _orderNumber = [aDecoder decodeObjectForKey:@"orderNumber"];
    
    _totalCash=[aDecoder decodeFloatForKey:@"totalNumbers"];;
    
    _totalNumbers=[aDecoder decodeIntForKey:@"totalNumbers"];
    
    _orderAduit = [aDecoder decodeObjectForKey:@"orderAduit"];
    
    _updateTime= [aDecoder decodeObjectForKey:@"updateTime"];
    
    _detailedAduit= [aDecoder decodeObjectForKey:@"detailedAduit"];
    
    _status= [aDecoder decodeObjectForKey:@"status"];
    
    _userBaseId=[aDecoder decodeIntegerForKey:@"userBaseId"];
    
    _orderAddressId=[aDecoder decodeIntegerForKey:@"orderAddressId"];
    
    _isInvoice= [aDecoder decodeObjectForKey:@"isInvoice"]; //是否开发票
    
    _isClub= [aDecoder decodeObjectForKey:@"isClub"]; //公司还是个人
    
   _invoiceTitle= [aDecoder decodeObjectForKey:@"invoiceTitle"]; //发票抬头
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"客户订单基础\t%lid, :订单数量 %ld, 总数量: %d \t订单编号: %@", (long)_id, (long)_orderNumber, _totalNumbers, _orderNumber];
}

@end
