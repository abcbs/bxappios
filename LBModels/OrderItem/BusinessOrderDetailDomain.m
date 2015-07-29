//
//  BusinessOrderDetailDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessOrderDetailDomain.h"

@implementation BusinessOrderDetailDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_businessBase forKey:@"businessBase"];
    
    [aCoder encodeObject:_businessOrder forKey:@"businessOrder"];
    
    [aCoder encodeObject:_orderDetailBusinessDomain forKey:@"orderDetailBusinessDomain"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _businessBase = [aDecoder decodeObjectForKey:@"businessBase"];
    
    _businessOrder = [aDecoder decodeObjectForKey:@"businessOrder"];
    
    _orderDetailBusinessDomain = [aDecoder decodeObjectForKey:@"orderDetailBusinessDomain"];
    
    return self;
}


@end
