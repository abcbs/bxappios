//
//  UserSession.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_username forKey:@"username"];
    
    [aCoder encodeObject:_status forKey:@"status"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _username = [aDecoder decodeObjectForKey:@"username"];
    
    _status = [aDecoder decodeObjectForKey:@"status"];

    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"会话信息\t%@\t用户名:%@", _sessionId,_username];
}
@end
