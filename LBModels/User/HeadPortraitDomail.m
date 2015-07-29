//
//  HeadPortraitDomail.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "HeadPortraitDomail.h"

@implementation HeadPortraitDomail

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_headPortrait forKey:@"headPortrait"];
    
    [aCoder encodeObject:_picSuffix forKey:@"picSuffix"];
 
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _headPortrait = [aDecoder decodeObjectForKey:@"headPortrait"];
    
    _picSuffix = [aDecoder decodeObjectForKey:@"picSuffix"];

    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"用户头像\t%@ \t头像后缀: %@", _sessionId, _picSuffix];
}
@end
