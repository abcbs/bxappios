//
//  OrderBaseAndDetailDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderBaseAndDetailDomain.h"

@implementation OrderBaseAndDetailDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_customerOrderBase forKey:@"customerOrderBase"];
    
    [aCoder encodeObject:_orderDetailBusinessDomain
                  forKey:@"orderDetailBusinessDomain"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _customerOrderBase = [aDecoder decodeObjectForKey:@"customerOrderBase"];
    
    _orderDetailBusinessDomain = [aDecoder decodeObjectForKey:@"orderDetailBusinessDomain"];
    
    return self;
}


@end
