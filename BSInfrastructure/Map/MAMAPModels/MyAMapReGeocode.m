//
//  MyAMapReGeocode.m
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyAMapReGeocode.h"

@implementation MyAMapReGeocode

- (id)initWithAMapReGeocode:(AMapReGeocode *)reGeocode
{
    if (self = [super init])
    {
        self.reGeocode = reGeocode;
    }
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}


@end
