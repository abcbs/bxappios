//
//  OrderBaseAndDetailListDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderBaseAndDetailListDomain.h"

@implementation OrderBaseAndDetailListDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_customerOrderBase forKey:@"customerOrderBase"];
    
    [aCoder encodeObject:_customerOrderDetaileds
                  forKey:@"customerOrderDetaileds"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _customerOrderBase = [aDecoder decodeObjectForKey:@"customerOrderBase"];
    
    _customerOrderDetaileds = [aDecoder decodeObjectForKey:@"customerOrderDetaileds"];
    
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
@end
