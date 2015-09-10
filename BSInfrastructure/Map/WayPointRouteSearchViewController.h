//
//  WayPointRouteSearchDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 13-7-14.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

#import "BSUIFrameworkHeader.h"
#import "BSUIKeyboardCoView.h"

@interface WayPointRouteSearchViewController : BSUICommonController <BMKMapViewDelegate, BMKRouteSearchDelegate,BSUIKeyboardCoViewDelegate,BMKSuggestionSearchDelegate> {
    
    IBOutlet UITextField* _startAddrText;
    IBOutlet UITextField* _wayPointAddrText;
    
    IBOutlet UITextField *_wayPointCity;
    
    
    IBOutlet UITextField* _endAddrText;
    
    IBOutlet UITextField *_endCityText;
    
    
    IBOutlet UITextField *_cityText;
    
    IBOutlet BMKMapView* _mapView;
    
    BMKRouteSearch* _routesearch;
    BMKSuggestionSearch* _searchersuggestionSearch;
    
    
}

@property (strong, nonatomic) IBOutlet UIView *controllerView;

-(IBAction)onDriveSearch;

- (IBAction)textFiledReturnEditing:(id)sender;
//键盘按钮
- (IBAction)keyAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
