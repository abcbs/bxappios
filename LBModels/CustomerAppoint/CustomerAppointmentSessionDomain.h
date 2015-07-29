//
//  CustomerAppointmentSessionDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
@class CustomerAppointment;

#import <Foundation/Foundation.h>

@interface CustomerAppointmentSessionDomain : NSObject

@property (nonatomic, retain) NSString * sessionId;

@property (nonatomic, retain)  CustomerAppointment* customerAppointment;

@end
