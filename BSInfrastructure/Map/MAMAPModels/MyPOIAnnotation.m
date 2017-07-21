//
//  MyPOIAnnotation.m
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyPOIAnnotation.h"

@implementation MyPOIAnnotation

- (id)initWithPOIAnnotation:(POIAnnotation *)poinnotation
{
    if (self = [super init])
    {
        self.poinnotation = poinnotation;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
