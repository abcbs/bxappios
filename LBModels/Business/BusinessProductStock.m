//
//  BusinessProductStock.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProductStock.h"

@implementation BusinessProductStock

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    [aCoder encodeInteger:_businessProductId forKey:@"businessProductId"];
    
    [aCoder encodeInteger:_businessId forKey:@"businessId"];
    
    [aCoder encodeInteger:_productId forKey:@"productId"];
    
    [aCoder encodeInteger:_numbers forKey:@"numbers"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeObject:_name forKey:@"name"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _businessProductId= [aDecoder decodeIntegerForKey:@"businessProductId"];
    
    _productId= [aDecoder decodeIntegerForKey:@"productId"];
    
    _businessId= [aDecoder decodeIntegerForKey:@"businessId"];
    
    _name=[aDecoder decodeObjectForKey:@"name"];
    
    _numbers= [aDecoder decodeIntegerForKey:@"numbers"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家产品评论\t%lid, :商品标示 %ld, 上架数量: %@ \t产品名称: %ld", (long)_id, (long)_businessProductId, _name, (long)_numbers];
}
@end
