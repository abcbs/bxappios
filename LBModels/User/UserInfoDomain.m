//
//  UserInfoDomain.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserInfoDomain.h"

@implementation UserInfoDomain

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_userBase forKey:@"userBase"];
    
    [aCoder encodeObject:_userDetailed forKey:@"userDetailed"];
    
    [aCoder encodeObject:_loginUser forKey:@"loginUser"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _userBase = [aDecoder decodeObjectForKey:@"userBase"];
    
    _userDetailed = [aDecoder decodeObjectForKey:@"userDetailed"];
    
    _loginUser = [aDecoder decodeObjectForKey:@"loginUser"];

    return self;
}



@end
