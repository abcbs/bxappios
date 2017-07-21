//
//  MyAMapPOI.m
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyAMapPOI.h"

@implementation MyAMapPOI


- (id)initWithAMapPOI:(AMapPOI *)poi
{
    if (self = [super init])
    {
        self.poi = poi;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
