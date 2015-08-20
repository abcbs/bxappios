//
//  Resources.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Resources.h"

@implementation Resources

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    
    [aCoder encodeObject:_resourceURL forKey:@"resourceURL"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeInteger:_metatype forKey:@"metatype"];
    

    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _resourceURL=[aDecoder decodeObjectForKey:@"resourceURL"];
    
    _name=[aDecoder decodeObjectForKey:@"name"];
    
    _metatype=[aDecoder decodeIntegerForKey:@"metatype"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"资源信息:%ld，URL:%@ 资源类型:%ld",
            (long)self.id,self.name,self.metatype];
}
@end
