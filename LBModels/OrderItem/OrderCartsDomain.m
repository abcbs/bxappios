//
//  OrderCartsDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderCartsDomain.h"

@implementation OrderCartsDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_businessCartDomain forKey:@"businessCartDomain"];

    [aCoder encodeObject:_customerOrderBase forKey:@"customerOrderBase"];
    
    [aCoder encodeObject:_userOrderAddress forKey:@"userOrderAddress"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _businessCartDomain = [aDecoder decodeObjectForKey:@"businessCartDomain"];
    
    _customerOrderBase = [aDecoder decodeObjectForKey:@"customerOrderBase"];
    
    _userOrderAddress = [aDecoder decodeObjectForKey:@"userOrderAddress"];
    
    return self;
}


@end
