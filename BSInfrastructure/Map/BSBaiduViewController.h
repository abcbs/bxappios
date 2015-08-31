//
//  BSBaiduViewController.h
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSCMFrameworkHeader.h"

@interface BSBaiduViewController : BSUICommonController<BMKMapViewDelegate,UIGestureRecognizerDelegate>


@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@end
