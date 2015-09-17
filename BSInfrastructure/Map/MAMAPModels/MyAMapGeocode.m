//
//  MyAMapGeocode.m
//  KTAPP
//
//  Created by admin on 15/9/17.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "MyAMapGeocode.h"

@implementation MyAMapGeocode
@synthesize geocode=_geocode;

- (id)initWithAMapGeocode:(AMapGeocode *)geocode
{
    if (self = [super init])
    {
        self.geocode = geocode;
    }
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
@end
