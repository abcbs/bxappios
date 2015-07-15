//
//  CustomerAppointmentSessionDomain.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomerAppointmentSessionDomain.h"

@implementation CustomerAppointmentSessionDomain

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_sessionId forKey:@"sessionId"];
    
    [aCoder encodeObject:_customerAppointment forKey:@"customerAppointment"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
    
    _customerAppointment = [aDecoder decodeObjectForKey:@"customerAppointment"];
    
    return self;
}

@end
