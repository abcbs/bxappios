//
//  MyAMapReGeocode.h
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MyAMapReGeocode : AMapReGeocode

@property (nonatomic, strong) AMapReGeocode *reGeocode;

- (id)initWithAMapReGeocode:(AMapReGeocode *)reGeocode;
@end
