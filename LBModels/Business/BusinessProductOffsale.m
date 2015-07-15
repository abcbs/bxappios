//
//  BusinessProductOffsale.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProductOffsale.h"

@implementation BusinessProductOffsale

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];

    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    return self;
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家商品上下架\t%lid, :商品标示 %ld, 商家标示: %ld \t上下架备注: %@", (long)_id, (long)_businessProductId, (long)_bussinessId, _comment];
}
@end
