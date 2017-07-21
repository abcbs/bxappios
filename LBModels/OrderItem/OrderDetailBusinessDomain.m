//
//  OrderDetailBusinessDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderDetailBusinessDomain.h"

@implementation OrderDetailBusinessDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_customerOrderDetailed forKey:@"customerOrderDetailed"];
    
    [aCoder encodeObject:_businessProduct forKey:@"businessProduct"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _customerOrderDetailed = [aDecoder decodeObjectForKey:@"customerOrderDetailed"];
    
    _businessProduct = [aDecoder decodeObjectForKey:@"businessProduct"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
