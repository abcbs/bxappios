//
//  GeoDetailViewController.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-23.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "BSUIFrameworkHeader.h"
#import "MyAMapGeocode.h"
@interface GeoDetailViewController : BSUICommonController

@property (nonatomic, strong) AMapGeocode *geocode;

@property (nonatomic, strong) MyAMapGeocode *geocodeCopy;
@end
