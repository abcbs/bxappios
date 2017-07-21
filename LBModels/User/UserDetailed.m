//
//  UserDetailed.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserDetailed.h"

@implementation UserDetailed

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_sex forKey:@"sex"];
    
    [aCoder encodeInteger:_userBaseId forKey:@"userBaseId"];
 
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _sex = [aDecoder decodeObjectForKey:@"sex"];
    
    _userBaseId = [aDecoder decodeIntegerForKey:@"userBaseId"];
    
    return self;
}


@end
