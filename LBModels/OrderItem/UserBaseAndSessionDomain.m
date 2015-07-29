//
//  UserBaseAndSessionDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserBaseAndSessionDomain.h"

@implementation UserBaseAndSessionDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_customerOrderBase forKey:@"customerOrderBase"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _customerOrderBase = [aDecoder decodeObjectForKey:@"customerOrderBase"];
    
    return self;
}

@end
