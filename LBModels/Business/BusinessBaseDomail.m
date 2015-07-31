//
//  BusinessBaseDomail.m
//  KTAPP
//  针对于业务的Domain对象，是BusinessBase、UserPay、ProductCatalogue、UserBase的属性集合
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessBaseDomail.h"

@implementation BusinessBaseDomail

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_businessBase forKey:@"businessBase"];
    
    [aCoder encodeObject:_userPay forKey:@"userPay"];
    
    [aCoder encodeObject:_artificial forKey:@"artificial"];
    
    [aCoder encodeObject:_contractUsers forKey:@"contractUsers"];
    
    [aCoder encodeObject:_contractUsers forKey:@"productCatalogues"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _businessBase = [aDecoder decodeObjectForKey:@"businessBase"];
    
    _userPay = [aDecoder decodeObjectForKey:@"userPay"];
   
    _artificial = [aDecoder decodeObjectForKey:@"artificial"];
   
    _contractUsers = [aDecoder decodeObjectForKey:@"contractUsers"];
    
    _productCatalogues=[aDecoder decodeObjectForKey:@"productCatalogues"];
    return self;
}


@end
