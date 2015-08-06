//
//  UserOrderAddress.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserOrderAddress.h"

@implementation UserOrderAddress

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_address forKey:@"address"];
    
    [aCoder encodeObject:_phone forKey:@"phone"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeInteger:_userId forKey:@"userId"];
    
    [aCoder encodeObject:_addressType forKey:@"addressType"];

    [aCoder encodeObject:_status forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _id=[aDecoder decodeIntegerForKey:@"id"];
    
    _name=[aDecoder decodeObjectForKey:@"name"];; //收货人姓名
    
    _address=[aDecoder decodeObjectForKey:@"address"];; //收货人地址
    
    _phone=[aDecoder decodeObjectForKey:@"phone"];; //收货人电话
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];;
    
    _userId=[aDecoder decodeIntegerForKey:@"userId"];
    
    _addressType=[aDecoder decodeObjectForKey:@"addressType"];;
    
    _status=[aDecoder decodeObjectForKey:@"status"];;
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"订货地址\t%lid, :地址名 %@, 地址: %@ \t联系电话: %@", (long)_id, _name, _address, _phone];
}
@end
