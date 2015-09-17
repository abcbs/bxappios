//
//  MyAMapGeocode.h
//  KTAPP
//
//  Created by admin on 15/9/17.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MyAMapGeocode : AMapGeocode

@property (nonatomic, strong) AMapGeocode *geocode;

- (id)initWithAMapGeocode:(AMapGeocode *)geocode;

@end
