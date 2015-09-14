//
//  BSMAMapMainViewController.m
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSMAMapMainViewController.h"
#import "BSIFTTHeader.h"

@interface BSMAMapMainViewController ()

//导航栏中显示和隐藏地图控制区域
- (IBAction)hideControllerClick:(id)sender;
@end

@implementation BSMAMapMainViewController

#pragma mark - Action Handlers

- (void)mapTypeAction:(UISegmentedControl *)segmentedControl
{
    self.mapView.mapType = segmentedControl.selectedSegmentIndex;
}

- (void)initToolBar
{
    /*
    UIBarButtonItem *flexbleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:self
                                                                                 action:nil];
    
    UISegmentedControl *mapTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                   [NSArray arrayWithObjects:
                                                    @"标准(Standard)",
                                                    @"卫星(Satellite)",
                                                    nil]];
    */
    mapTypeSegmentedControl.selectedSegmentIndex  = self.mapView.mapType;
    [mapTypeSegmentedControl addTarget:self action:@selector(mapTypeAction:) forControlEvents:UIControlEventValueChanged];
    /*
    UIBarButtonItem *mayTypeItem = [[UIBarButtonItem alloc] initWithCustomView:mapTypeSegmentedControl];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexbleItem, mayTypeItem, flexbleItem, nil];
    */ 
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initToolBar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    //self.navigationController.toolbar.translucent   = YES;
    //[self.navigationController setToolbarHidden:NO animated:animated];
}

-(void)initSubViews{
    mapControllerView.hidden=YES;
}

#pragma mark -导航栏地图隐藏/控制显示
- (IBAction)hideControllerClick:(id)sender {
     [self hideController];
}

#pragma mark -状态栏中显示/隐藏控制
-(void)hideController{
    mapControllerView.hidden=NO;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"隐藏控制" style:UIBarButtonItemStylePlain target:self action:@selector(displayControllerView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
}

-(void)displayControllerView{
    mapControllerView.hidden=YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"显示控制" style:UIBarButtonItemStylePlain target:self action:@selector(hideControllerClick:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
}
@end
