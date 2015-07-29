//
//  UserPaySessionDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserPaySessionDomain.h"

@implementation UserPaySessionDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_userPay forKey:@"userPay"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _userPay = [aDecoder decodeObjectForKey:@"userPay"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"用户支付域,会话ID\t%@",_sessionId];
}
@end
