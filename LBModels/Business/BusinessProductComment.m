//
//  BusinessProductComment.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProductComment.h"

@implementation BusinessProductComment

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
   [aCoder encodeInteger:_businessProductId forKey:@"businessProductId"];
    
    [aCoder encodeObject:_comment forKey:@"comment"];
    
    [aCoder encodeInteger:_productBaseId forKey:@"productBaseId"];
    
   [aCoder encodeObject:_userName forKey:@"userName"];
    
    [aCoder encodeInteger:_userBaseId forKey:@"userBaseId"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _businessProductId= [aDecoder decodeIntegerForKey:@"businessProductId"];
    
    _comment=[aDecoder decodeObjectForKey:@"comment"];
    
    _productBaseId= [aDecoder decodeIntegerForKey:@"productBaseId"];
    
    _userName=[aDecoder decodeObjectForKey:@"comment"];
    
    _userBaseId=[aDecoder decodeIntegerForKey:@"userBaseId"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家产品评论\t%lid, :商品标示 %ld, 评论者: %@ \t评论: %@", (long)_id, (long)_businessProductId, _userName, _comment];
}


@end
