//
//  CustomerAppointment.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomerAppointment.h"

@implementation CustomerAppointment


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    [aCoder encodeInteger: _productCatalogId forKey:@"productCatalogId"];
    
    [aCoder encodeInteger: _appointAddressId forKey:@"appointAddressId"];
    
    [aCoder encodeInteger: _userId forKey:@"userId"];
    
    [aCoder encodeObject:  _appointComment forKey:@"appointComment"];
    
    [aCoder encodeObject:  _appointTime forKey:@"appointTime"];
    
    [aCoder encodeObject:  _appointStartTime forKey:@"appointStartTime"];
    
    [aCoder encodeObject:  _appointEndTime forKey:@"appointEndTime"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
   _productCatalogId= [aDecoder decodeIntegerForKey:@"productCatalogId"];
    
    _appointComment=[aDecoder decodeObjectForKey:@"appointComment"];
    
    _appointTime=[aDecoder decodeObjectForKey:@"appointTime"];
    
   _appointStartTime= [aDecoder decodeObjectForKey:@"appointStartTime"];
    
    _appointEndTime= [aDecoder decodeObjectForKey:@"appointEndTime"];
    
    _appointAddressId= [aDecoder decodeIntegerForKey:@"appointAddressId"];
    
    _userId =[aDecoder decodeIntegerForKey:@"userId"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"商圈预约:%ld，预约备注:%@ 预约服务类型:%ld\t预约人ID:%ld",
            (long)self.id,self.appointComment,(long)self.productCatalogId,self.userId];
}

@end
