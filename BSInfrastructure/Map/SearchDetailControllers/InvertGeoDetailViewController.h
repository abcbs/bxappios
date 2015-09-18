//
//  InvertGeoDetailViewController.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-26.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "MyAMapReGeocode.h"

@interface InvertGeoDetailViewController : UIViewController

@property (nonatomic, strong) AMapReGeocode *reGeocode;

@property (nonatomic, strong) MyAMapReGeocode *reGeocodeCopy;

@end
