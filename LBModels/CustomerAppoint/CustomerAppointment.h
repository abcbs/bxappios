//
//  CustomerAppointment.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerAppointment : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger productCatalogId;

@property (nonatomic, retain) NSString * appointComment;

@property (nonatomic, retain) NSDate *appointTime;

@property (nonatomic, retain) NSDate * appointStartTime;

@property (nonatomic, retain) NSDate * appointEndTime;

@property (nonatomic, assign) NSInteger appointAddressId;

@property (nonatomic, assign) NSInteger userId;


@end
