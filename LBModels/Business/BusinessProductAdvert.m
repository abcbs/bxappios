//
//  BusinessProductAdvert.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProductAdvert.h"

@implementation BusinessProductAdvert
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    [aCoder encodeInteger: _productBaseId forKey:@"productBaseId"];
    
    [aCoder encodeInteger: _businessId forKey:@"businessId"];
    
    [aCoder encodeObject:_troduce forKey:@"troduce"];
    
    [aCoder encodeInteger: _resourceId forKey:@"resourceId"];
    
    [aCoder encodeObject:_startTime forKey:@"startTime"];
    
    [aCoder encodeObject:_endTime forKey:@"endTime"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _productBaseId= [aDecoder decodeIntegerForKey:@"productBaseId"];
    
    _businessId= [aDecoder decodeIntegerForKey:@"businessId"];
    
    _troduce=[aDecoder decodeObjectForKey:@"troduce"];
    
    _resourceId= [aDecoder decodeIntegerForKey:@"resourceId"];
    
    _startTime=[aDecoder decodeObjectForKey:@"startTime"];
    
    _endTime=[aDecoder decodeObjectForKey:@"endTime"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
        
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家广告\t%lid, :商品标示 %ld, 商家标示: %ld \t广告内容: %@", (long)_id, (long)_productBaseId, (long)_businessId, _troduce];
}
@end
