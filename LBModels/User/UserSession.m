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
    
    [aCoder encodeObject:_userName forKey:@"userName"];
    
    [aCoder encodeObject:_status forKey:@"status"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _userName = [aDecoder decodeObjectForKey:@"userName"];
    
    _status = [aDecoder decodeObjectForKey:@"status"];

    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"会话信息\t%@\t用户名:%@", _sessionId,_userName];
}
@end
