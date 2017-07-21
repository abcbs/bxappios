//
//  BusinessCatalogue.m
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessCatalogue.h"

@implementation BusinessCatalogue


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    
    [aCoder encodeInteger:_businessId forKey:@"businessId"];
    
    [aCoder encodeInteger:_cataloguecode forKey:@"cataloguecode"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
     _cataloguecode= [aDecoder decodeIntegerForKey:@"cataloguecode"];
    
    _businessId= [aDecoder decodeIntegerForKey:@"businessId"];
    
    _name=[aDecoder decodeObjectForKey:@"name"];
    
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家经营范围\t%lid, :businessid %ld \t经营范围名称: %@", (long)_id, (long)_businessId, _name];
}

@end
