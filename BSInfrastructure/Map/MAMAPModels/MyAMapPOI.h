//
//  MyAMapPOI.h
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <AMapSearchKit/AMapSearchAPI.h>

@interface MyAMapPOI : AMapPOI

@property (nonatomic, strong) AMapPOI *poi;

- (id)initWithAMapPOI:(AMapPOI *)poi;

@end
