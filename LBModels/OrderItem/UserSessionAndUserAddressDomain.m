//
//  UserSessionAndUserAddressDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserSessionAndUserAddressDomain.h"

@implementation UserSessionAndUserAddressDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_userSession forKey:@"userSession"];
    
    [aCoder encodeObject:_userOrderAddress forKey:@"userOrderAddress"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _userSession = [aDecoder decodeObjectForKey:@"userSession"];
    
    _userOrderAddress = [aDecoder decodeObjectForKey:@"userOrderAddress"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
