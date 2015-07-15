//
//  ProductCatalogue.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ProductCatalogue.h"

@implementation ProductCatalogue

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    //编码
    [aCoder encodeObject:_code forKey:@"code"];
    //备注
    [aCoder encodeObject:_comment forKey:@"comment"];
    //状态
    [aCoder encodeObject:_status forKey:@"status"];
    //更新时间
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeInteger:_serialize  forKey:@"serialize"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
     //编码
    _code= [aDecoder decodeObjectForKey:@"code"];
    //备注
    _comment= [aDecoder decodeObjectForKey:@"comment"];
    //状态
    _status= [aDecoder decodeObjectForKey:@"status"];
    //更新时间
    _updateTime= [aDecoder decodeObjectForKey:@"updateTime"];
    
    _serialize= [aDecoder decodeIntegerForKey:@"serialize"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"服务与商品类型\t%@, 备注 %@, 序号: %ld", _code, _comment, (long)_serialize];
}
@end
