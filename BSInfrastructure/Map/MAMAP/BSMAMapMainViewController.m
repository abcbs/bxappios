//
//  BSMAMapMainViewController.m
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSMAMapMainViewController.h"
#import "BSIFTTHeader.h"
#import "ScreenshotDetailViewController.h"
#import "GeocodeAnnotation.h"
#import "CommonUtility.h"

@interface BSMAMapMainViewController ()<UIGestureRecognizerDelegate ,UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIImage *screenshotImage ;
}


//导航栏中显示和隐藏地图控制区域
- (IBAction)hideControllerClick:(id)sender;

@property (nonatomic, strong) UILabel *tip;

//自定义定位
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

//地图快照
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) MACircle *circle;

@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic) BOOL started;
//
@end

@implementation BSMAMapMainViewController
@synthesize tip       = _tip;

@synthesize pan        = _pan;
@synthesize shapeLayer = _shapeLayer;
@synthesize started    = _started;


@synthesize tips=_tips;
#pragma mark - Action Handlers

- (void)mapTypeAction:(UISegmentedControl *)segmentedControl
{
    self.mapView.mapType = segmentedControl.selectedSegmentIndex;
}



#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark 继承父类方法，键盘处理事件
-(void)delelageForTextField{
    
    //比例
    zoomdegree.delegate=self;
    
    //旋转度
    rotatedegree.delegate=self;
    
    //俯视度
    overlookdegree.delegate=self;
    
    //
    cityText.delegate=self;
    
    //查询地址
    addressText.delegate=self;
    
    //经度
    longitudeText.delegate=self;
    
    //纬度
    latitudeText.delegate=self;
    
    //查找访问
    rangRadius.delegate=self;
    
    //查询关键字
    keyText.delegate=self;
    
    //道路规划
    endCityText.delegate=self;
    
    //终点地址
    endAddressText.delegate=self;

    
}

#pragma mark -继承父类方法对视图格式化
-(void)initSubViews{
    //基本控制
    [BSUIComponentView configButtonStyle:screenShotAction];
    [BSUIComponentView configButtonStyle:saveScreenShotAction];
    [BSUIComponentView configButtonStyle:zoomLevelAction];
    [BSUIComponentView configButtonStyle:rotatedegreeAction];
    [BSUIComponentView configButtonStyle:overlookdegreeAction];
    
    //地图查询，POI查询
    [BSUIComponentView configButtonStyle:geoAction];
    [BSUIComponentView configButtonStyle:revGeoAction];
    [BSUIComponentView configButtonStyle:poiNextAction];
    [BSUIComponentView configButtonStyle:poiFindAction];
    [BSUIComponentView configButtonStyle:poiSaveAction];
    [BSUIComponentView configButtonStyle:favBrowser];
    [BSUIComponentView configButtonStyle:favDelete];
    [BSUIComponentView configButtonStyle:favSave];

    //线路规划
    [BSUIComponentView configButtonStyle:routeByBusAction];
    [BSUIComponentView configButtonStyle:routeBySelfDriving];
    [BSUIComponentView configButtonStyle:routteByTrampAction];
    [BSUIComponentView configButtonStyle:routeByBikeAction];
    [BSUIComponentView configButtonStyle:addressSharedAction];
    [BSUIComponentView configButtonStyle:geoSharedAction];
    [BSUIComponentView configButtonStyle:browseUrlAction];
    
    mapControllerView.hidden=YES;
    //显示控制区域
    [controllerSegmented addTarget:self action:@selector(changeControllerType:) forControlEvents:UIControlEventValueChanged];
    
    //默认情况
    [baseUIControllerView setHidden:YES];
    [localtionUIControllerView setHidden:YES];
    [searchUIControllerView setHidden:NO];
    controllerSegmented.selectedSegmentIndex=1;
    
    
    //地图种类Action
    mapTypeSegmentedControl.selectedSegmentIndex  = self.mapView.mapType;
    [mapTypeSegmentedControl addTarget:self action:@selector(mapTypeAction:) forControlEvents:UIControlEventValueChanged];
    
    //定位开关
    [showUserLocationSegment addTarget:self action:@selector(showsSegmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //定位开关
    [modeUserLocationSegment addTarget:self action:@selector(modeAction:) forControlEvents:UIControlEventValueChanged];
    
    //交通路况
    [trafficSwitch addTarget:self action:@selector(trafficAction:) forControlEvents:UIControlEventValueChanged];
    trafficSwitch.on = YES;
    
    //手势放大、缩小
    [gestureScorllction addTarget:self action:@selector(gestureScorllAction:) forControlEvents:UIControlEventValueChanged];
    gestureScorllction.on = YES;
    
    [gestureZoomAction addTarget:self action:@selector(gestureZoomAction:) forControlEvents:UIControlEventValueChanged];
    gestureScorllction.on = YES;
    
    [gestureRotateSwitch addTarget:self action:@selector(gestureRotateAction:) forControlEvents:UIControlEventValueChanged];
    gestureRotateSwitch.on=YES;
    
    [gestureCameraSwitch addTarget:self action:@selector(gestureCameraAction:) forControlEvents:UIControlEventValueChanged];
    gestureCameraSwitch.on=YES;
    
    //手势
    // 需要额外添加一个双击手势，以避免当执行mapView的双击动作时响应两次单击手势。
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:doubleTap];
    //
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [self.view addGestureRecognizer:singleTap];
    
    //快照手势
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    self.pan.delegate = self;
    self.pan.maximumNumberOfTouches = 1;
    
    [self.view addGestureRecognizer:self.pan];

    [self initShapeLayer];
    
    self.shapeLayer.hidden=YES;
    
    //
    addressSearchBar.translucent  = YES;
    addressSearchBar.delegate     = self;
    addressSearchBar.keyboardType = UIKeyboardTypeDefault;
    tableView.dataSource=self;
    tableView.delegate=self;

}

/* 地理编码 搜索. */
- (void)searchGeocodeWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = key;
    
    [self.search AMapGeocodeSearch:geo];
}

/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    NSArray *cities=[[NSArray alloc] initWithObjects:@"北京市",nil];
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.city=cities;
    tips.keywords = key;
    [self.search AMapInputTipsSearch:tips];
}

/* 清除annotation. */
- (void)clear
{
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)clearAndSearchGeocodeWithKey:(NSString *)key
{
    /* 清除annotation. */
    [self clear];
    
    [self searchGeocodeWithKey:key];
}

- (void)gotoDetailForGeocode:(AMapGeocode *)geocode
{
    BSLog(@"进入地图详细信息页");
    if (geocode != nil)
    {
        /*
        GeoDetailViewController *geoDetailViewController = [[GeoDetailViewController alloc] init];
        geoDetailViewController.geocode = geocode;
        
        [self.navigationController pushViewController:geoDetailViewController animated:YES];
        */
    }
}

#pragma mark - AMapSearchDelegate

/* 地理编码回调.*/
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
    }
    else
    {
        [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotations]
                               animated:YES];
    }
    
    [self.mapView addAnnotations:annotations];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    NSArray *array=response.tips;
    
    if (self.tips==nil) {
        self.tips=[NSMutableArray arrayWithArray:array];
    }else{
        [self.tips setArray:response.tips];
    }
    //
    if ([array count]>0) {
        [tableView reloadData];
        [tableView setHidden:NO];
        [self.mapView setHidden:YES];
    }
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *key = searchBar.text;
    [self searchTipsWithKey:key];
    [addressSearchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
    }
    
    AMapTip *tip = self.tips[indexPath.row];
    
    cell.textLabel.text = tip.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = self.tips[indexPath.row];
    
    [self clearAndSearchGeocodeWithKey:tip.name];
    addressSearchBar.placeholder = tip.name;
    addressSearchBar.text=tip.name;
    addressText.text=tip.name;
    [self.mapView setHidden:NO];
    tableView.hidden=YES;
}

- (void)initAnnotationAndOverlay
{
    self.pointAnnotation = [[MAPointAnnotation alloc] init];
    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.911447, 116.406026);
    self.pointAnnotation.title      = @"Why Not!";
    
    self.circle = [MACircle circleWithCenterCoordinate:self.pointAnnotation.coordinate radius:5000];
}
- (void)initShapeLayer
{
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth   = 2;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor   = [[UIColor grayColor] colorWithAlphaComponent:0.3f].CGColor;
    self.shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], nil];
    
    CGPathRef path = CGPathCreateWithRect(CGRectInset(self.view.bounds,
                                                      CGRectGetWidth(self.view.bounds)  / 4.f,
                                                      CGRectGetHeight(self.view.bounds) / 4.f),
                                          NULL);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    
    [self.view.layer addSublayer:self.shapeLayer];
}


- (void)changeControllerType:(id)sender {
    NSInteger index = controllerSegmented.selectedSegmentIndex;
    switch (index) {
        case 0://基本的
            [baseUIControllerView setHidden:NO];
            [localtionUIControllerView setHidden:YES];
            [searchUIControllerView setHidden:YES];
            break;
            
        case 1://检查
            [baseUIControllerView setHidden:YES];
            [localtionUIControllerView setHidden:YES];
            [searchUIControllerView setHidden:NO];
            break;
            
        case 2://定位
            [baseUIControllerView setHidden:YES];
            [localtionUIControllerView setHidden:NO];
            [searchUIControllerView setHidden:YES];
            break;
            
        default:
            [baseUIControllerView setHidden:YES];
            [localtionUIControllerView setHidden:YES];
            [searchUIControllerView setHidden:NO];
            break;
    }
}


- (IBAction)snapCaptureClick:(id)sender {
    //[self captureAction];
    [self startupAction];
}

- (IBAction)snapSaveClick:(id)sender {
    //[self captureAction];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (screenshotImage==nil){
        
    }
    if ([segue.identifier isEqualToString:@"showSnapMap"])
    {//浏览信息
        [self captureAction];
        ScreenshotDetailViewController *detailViewController =
        (ScreenshotDetailViewController *)segue.destinationViewController;

        detailViewController.screenshotImage = screenshotImage;
        detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    }
   
}


//交通路况Action
- (void)trafficAction:(UISwitch *)switcher
{
    self.mapView.showTraffic = switcher.on;
}

//手势放大、缩小
- (void)gestureScorllAction:(UISwitch *)switcher
{
    self.mapView.zoomEnabled = switcher.on;
    
}

//收缩、俯视、旋转度操作
- (IBAction)overlookdegreeClick:(id)sender {
    self.mapView.cameraDegree=[overlookdegree.text doubleValue];
}

- (IBAction)zoomLevelClick:(id)sender {
    [self.mapView setZoomLevel:[zoomdegree.text floatValue] animated:YES];
    
}

- (IBAction)rotatedegreeClick:(id)sender {
    self.mapView.rotationDegree=[rotatedegree.text doubleValue];
}

//手势移动
- (void)gestureZoomAction:(UISwitch *)switcher{
     self.mapView.scrollEnabled = switcher.on;
}

//手势旋转
- (void)gestureRotateAction:(UISwitch *)switcher{
    self.mapView.rotateEnabled = switcher.on;
}

//手势拍照
- (void)gestureCameraAction:(UISwitch *)switcher{
    self.mapView.rotateCameraEnabled = switcher.on;
}

- (void)showsSegmentAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==0){
        modeUserLocationSegment.enabled=YES;
        [self.mapView setZoomLevel:16.1 animated:YES];
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    }else{
       modeUserLocationSegment.enabled=NO;
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    
    self.mapView.showsUserLocation = !sender.selectedSegmentIndex;
}

- (void)modeAction:(UISegmentedControl *)sender
{
    self.mapView.userTrackingMode = sender.selectedSegmentIndex;
}

- (void)captureAction
{
    if (self.shapeLayer.path == NULL)
    {
        return;
    }
    
    CGRect inRect = [self.view convertRect:CGPathGetPathBoundingBox(self.shapeLayer.path)
                                    toView:self.mapView];
    
    screenshotImage = [self.mapView takeSnapshotInRect:inRect];
}

- (void)startupAction
{
    self.started = !self.started;
    
    self.mapView.scrollEnabled = !self.started;
    
    self.shapeLayer.hidden = !self.started;
}


//手势
- (void)showLabelWithText:(NSString *)text atPoint:(CGPoint)centerPoint
{
    if (self.tip == nil)
    {
        self.tip = [[UILabel alloc] init];
        self.tip.backgroundColor = [UIColor clearColor];
        self.tip.textColor       = [UIColor redColor];
        self.tip.font            = [UIFont systemFontOfSize:80];
        
        [self.view addSubview:self.tip];
    }
    
    self.tip.text   = text;
    [self.tip sizeToFit];
    self.tip.alpha  = 1.f;
    self.tip.center = centerPoint;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.pan == gestureRecognizer)
    {
        return self.started;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)panGesture:(UIPanGestureRecognizer *)panGesture
{
    static CGPoint startPoint;
    
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        self.shapeLayer.path = NULL;
        
        startPoint = [panGesture locationInView:self.view];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [panGesture locationInView:self.view];
        CGPathRef path = CGPathCreateWithRect(CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y), NULL);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == singleTap && ([touch.view isKindOfClass:[UIControl class]] || [touch.view isKindOfClass:[MAAnnotationView class]]))
    {
        return NO;
    }
    
    if (gestureRecognizer == doubleTap && [touch.view isKindOfClass:[UIControl class]])
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - Handle Gestures

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap
{
    [self showLabelWithText:@"一下" atPoint:[theSingleTap locationInView:self.view]];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tip.alpha = 0.0;
    }];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap
{
    [self showLabelWithText:@"扩大" atPoint:[theDoubleTap locationInView:self.view]];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tip.alpha = 0.0;
    }];
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


#pragma mark -高德地图

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }

}

//自定义定位
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
        
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleView;
    }
    
    return nil;
}

//自定义定位
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForMAUserLocationAnnotation:(id<MAAnnotation>)annotation{
    static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
    if (annotationView == nil)
    {
        annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:userLocationStyleReuseIndetifier];
    }
    
    annotationView.image = [UIImage imageNamed:@"userPosition"];
    
    self.userLocationAnnotationView = annotationView;
    
    return annotationView;

}

//地理编码
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForGeocodeAnnotationAnnotation:(id<MAAnnotation>)annotation{
    static NSString *geoCellIdentifier = @"geoCellIdentifier";
    
    MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:geoCellIdentifier];
    if (poiAnnotationView == nil)
    {
        poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                            reuseIdentifier:geoCellIdentifier];
    }
    
    poiAnnotationView.canShowCallout            = YES;
    poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return poiAnnotationView;

}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        return [self mapView:mapView
            viewForMAUserLocationAnnotation:annotation];
    }
    if ([annotation isKindOfClass:[GeocodeAnnotation class]])
    {
        return [self mapView:mapView
            viewForGeocodeAnnotationAnnotation:annotation];
    }

    return nil;
}

@end
