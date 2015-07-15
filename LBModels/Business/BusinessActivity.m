//
//  BusinessActivity.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessActivity.h"

@implementation BusinessActivity

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    
    [aCoder encodeObject:_title forKey:@"title"];
    
    [aCoder encodeObject:_content forKey:@"content"];
    
    [aCoder encodeObject:_startTime forKey:@"startTime"];
    
    [aCoder encodeObject:_endTime forKey:@"endTime"];
    //活动地点
    [aCoder encodeObject:_place forKey:@"place"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_isEnabled forKey:@"isEnabled"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _title=[aDecoder decodeObjectForKey:@"title"];
    
    _content=[aDecoder decodeObjectForKey:@"content"];
    
    _startTime=[aDecoder decodeObjectForKey:@"startTime"];
    
    _endTime=[aDecoder decodeObjectForKey:@"endTime"];
    //活动地点
    _place=[aDecoder decodeObjectForKey:@"place"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _isEnabled=[aDecoder decodeObjectForKey:@"isEnabled"];
    
    return self;
}


-(NSString *)description{
    return [NSString stringWithFormat:@"商家活动:%ld，活动标题:%@ 活动内容:%@",
            (long)self.id,self.title,self.content];
}

@end
