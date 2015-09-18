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
#import "MyAMapGeocode.h"
#import "GeoDetailViewController.h"
#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"
#import "InvertGeoDetailViewController.h"
#import "POIAnnotation.h"
#import "PoiDetailViewController.h"

#define RightCallOutTag 1
#define LeftCallOutTag 2

@interface BSMAMapMainViewController ()<UIGestureRecognizerDelegate ,UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIImage *screenshotImage ;
    int curPage;
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

@property (nonatomic) AMapSearchType searchType;

@property (nonatomic) BOOL started;
//
@end

@implementation BSMAMapMainViewController
@synthesize tip       = _tip;

@synthesize pan        = _pan;
@synthesize shapeLayer = _shapeLayer;
@synthesize started    = _started;


@synthesize tips=_tips;

@synthesize searchType=_searchType;

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
    [tableView setHidden:YES];
    [self.tips removeAllObjects];
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
    
    //长摁
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleLongPressForRevertGeo:)];
    longPress.minimumPressDuration = 0.5;
    longPress.delegate = self;
    
    [self.view addGestureRecognizer:longPress];

    [self initShapeLayer];
    
    self.shapeLayer.hidden=YES;
    
    //
    addressSearchBar.translucent  = YES;
    addressSearchBar.delegate     = self;
    addressSearchBar.keyboardType = UIKeyboardTypeDefault;
    tableView.dataSource=self;
    tableView.delegate=self;

}

- (void)handleLongPressForRevertGeo:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CLLocationCoordinate2D coordinate =
        [self.mapView convertPoint:[longPress locationInView:self.view]
              toCoordinateFromView:self.mapView];
        //已经获取经纬度
        BSLog(@"onLongClick-latitude==%f,longitude==%f",
               coordinate.latitude,coordinate.longitude);
       
        NSString* showmeg = [NSString stringWithFormat:@"点击获得经纬度,当前经度:%f,当前纬度:%f",coordinate.longitude,coordinate.latitude];
        
        _showMsgLabel.text = showmeg;
        
        
        
        longitudeText.text = [NSString stringWithFormat:@"%f",
                              coordinate.longitude];//纬度
        
        latitudeText.text = [NSString stringWithFormat:@"%f",
                             coordinate.latitude];//经度

        [self searchReGeocodeWithCoordinate:coordinate];
    }
}

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    regeo.radius=5000;
    [self.search AMapReGoecodeSearch:regeo];
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
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.city=@[cityText.text];
    tips.keywords = key;
    [self.search AMapInputTipsSearch:tips];
}

/* 清除annotation. */
- (void)clear
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.tips removeAllObjects];
}

- (void)clearAndSearchGeocodeWithKey:(NSString *)key
{
    /* 清除annotation. */
    [self clear];
    
    [self searchGeocodeWithKey:key];
}

//正向进入详细
- (void)gotoDetailForGeocode:(AMapGeocode *)geocode
{
    if (geocode != nil)
    {
        MyAMapGeocode *myAMapGeocode=[[MyAMapGeocode alloc]initWithAMapGeocode:geocode];
        BSTableContentObject *geoDetailContentObject=[BSTableContentObject
                                     initWithContentObject:nil
                                     methodName:@"geocodeCopy" imageName:nil
                                     colClass:[GeoDetailViewController class]];
 
        geoDetailContentObject.neededMethodData=myAMapGeocode;
        [self navigating:geoDetailContentObject];

    }
}

//反向进入详细
- (void)gotoDetailForReGeocode:(AMapReGeocode *)reGeocode
{
    if (reGeocode != nil)
    {
        /*
        InvertGeoDetailViewController *invertGeoDetailViewController = [[InvertGeoDetailViewController alloc] init];
        
        invertGeoDetailViewController.reGeocode = reGeocode;
        
        [self.navigationController pushViewController:invertGeoDetailViewController animated:YES];
        */
        MyAMapReGeocode *myReAMapGeocode=[[MyAMapReGeocode alloc]initWithAMapReGeocode:reGeocode];
        
        BSTableContentObject *reGeocodeContentObject=[BSTableContentObject
             initWithContentObject:nil
              methodName:@"reGeocodeCopy" imageName:nil
              colClass:[InvertGeoDetailViewController class]];
        
        reGeocodeContentObject.neededMethodData=myReAMapGeocode;
        [self navigating:reGeocodeContentObject];

    }
}

#pragma mark - AMapSearchDelegate
//地图标注点击事件
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[GeocodeAnnotation class]])
    {
        [self gotoDetailForGeocode:[(GeocodeAnnotation*)view.annotation geocode]];
    }
    if ([view.annotation isKindOfClass:[ReGeocodeAnnotation class]]){
        [self mapView:mapView annotationViewForRevertGeo:view calloutAccessoryControlTapped:control];
    }
    if ([view.annotation isKindOfClass:[POIAnnotation class]]){
        [self mapView:mapView annotationPOIAnnotationView:view calloutAccessoryControlTapped:control];
    }
}

- (void)mapView:(MAMapView *)mapView annotationViewForRevertGeo:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
        if ([control tag] == RightCallOutTag)
        {
            [self gotoDetailForReGeocode:[(ReGeocodeAnnotation*)view.annotation reGeocode]];
        }
        else if([control tag] == LeftCallOutTag)
        {
            MANaviConfig *config = [MANaviConfig new];
            config.destination = view.annotation.coordinate;
            config.appScheme = [self getApplicationScheme];
            config.appName = [self getApplicationName];
            // config.style = MADrivingStrategyFastest;
            //调客户端
            if(![MAMapURLSearch openAMapNavigation:config])
            {
                [MAMapURLSearch getLatestAMapApp];
            }
        }
}

- (void)mapView:(MAMapView *)mapView annotationPOIAnnotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id<MAAnnotation> annotation = view.annotation;
    
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
        
        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
        detail.poi = poiAnnotation.poi;
        
        /* 进入POI详情页面. */
        [self.navigationController pushViewController:detail animated:YES];
    }
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

    if ([array count]>0) {
        [tableView reloadData];
        [tableView setHidden:NO];
    }else{
        [tableView setHidden:YES];
        [self.tips removeAllObjects];
    }
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *key = searchBar.text;
    [self searchTipsWithKey:key];
    [addressSearchBar resignFirstResponder];
    [tableView setHidden:NO];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请选择下面地址";
}

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
    //[self.mapView setHidden:NO];
    tableView.hidden=YES;
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

//快照手势
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
/* POI 搜索回调. */
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)respons
{
    if (request.searchType != self.searchType)
    {
        return;
    }
    
    if (respons.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:respons.pois.count];
    
    [respons.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    //画出圈
    /* Circle. */
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake([latitudeText.text doubleValue], [longitudeText.text doubleValue]) radius:[rangRadius.text doubleValue]];
    //[self.overlaysAboveRoads addObject:circle];
    [self.mapView addOverlay:circle level:MAOverlayLevelAboveRoads];

    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        self.mapView.centerCoordinate = [poiAnnotations[0] coordinate];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:YES];
    }
}



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
        //地理编码
        GeocodeAnnotation *geoAnnotation=(GeocodeAnnotation*)annotations[0];
        //_geocode	AMapGeocode *	0x1702b75e0	0x00000001702b75e0
        AMapGeocode * geocode=geoAnnotation.geocode;
        
        CLLocationCoordinate2D coor=[annotations[0] coordinate];
        BSLog(@"onLongClick-latitude==%f,longitude==%f",coor.latitude,coor.longitude);
        NSString* showmeg = [NSString stringWithFormat:@"地址:%@,当前经度:%f,当前纬度:%f", geocode.formattedAddress,coor.longitude,coor.latitude];
        
        _showMsgLabel.text = showmeg;
        
        cityText.text=geocode.city;
        
        addressText.text=geocode.formattedAddress;
        
        longitudeText.text = [NSString stringWithFormat:@"%f",
                              coor.longitude];//纬度
        
        latitudeText.text = [NSString stringWithFormat:@"%f",
                             coor.latitude];//经度
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
        
    }
    else
    {
        [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotations]
                               animated:YES];
    }
    
    [self.mapView addAnnotations:annotations];
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
    }
}

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
    }else if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth    = 2.f;
        //circleView.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        //circleView.fillColor    = [UIColor whiteColor];
        circleView.lineDash     = YES;
        
        return circleView;
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

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForRevertAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        static NSString *invertGeoIdentifier = @"invertGeoIdentifier";
        
        MANaviAnnotationView *poiAnnotationView = (MANaviAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:invertGeoIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:invertGeoIdentifier];
        }
        
        poiAnnotationView.animatesDrop              = YES;
        poiAnnotationView.canShowCallout            = YES;
        poiAnnotationView.draggable = NO;
        
        //show detail by right callout accessory view.
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        poiAnnotationView.rightCalloutAccessoryView.tag = RightCallOutTag;
        
        //call online navi by left accessory.
        poiAnnotationView.leftCalloutAccessoryView.tag = LeftCallOutTag;
        
        return poiAnnotationView;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForPOIAnnotationAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout            = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
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
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]]){
        return [self mapView:mapView
            viewForRevertAnnotation:annotation];
    }
    if ([annotation isKindOfClass:[POIAnnotation class]]){
        return [self mapView:mapView
            viewForPOIAnnotationAnnotation:annotation];
    }
    return nil;
}

//POI查找如果坐标不为空，则执行周边查找，
- (IBAction)poiFindClick:(id)sender {
    curPage = 0;
    [self clearMapData];
    if ([keyText.text isEqualToString:@""]) {
        [self searchPoiByKeyword];
    }else{
        [self searchPoiByCenterCoordinate];
    }
}

- (IBAction)poiNextPageClick:(id)sender {
    curPage++;
    if ([keyText.text isEqualToString:@""]) {
        [self searchPoiByKeyword];
    }else{
        [self searchPoiByCenterCoordinate];
    }
}

- (IBAction)poiResultSave:(id)sender {
    
}


/* 根据关键字来搜索POI. */
- (void)searchPoiByKeyword
{
    self.searchType=2;
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_PlaceKeyword;
    request.keywords            = addressText.text;
    request.city                = @[cityText.text];
    request.requireExtension    = YES;
    request.page=curPage;
    //每页多少
    request.offset=20;
    [self.search AMapPlaceSearch:request];
}

/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    self.searchType=3;
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_PlaceAround;
    request.location            = [AMapGeoPoint locationWithLatitude:[latitudeText.text doubleValue]
                                                           longitude:[longitudeText.text doubleValue]];
    request.keywords            = keyText.text;
    /* 按照距离排序. */
    request.sortrule            = 1;
    request.requireExtension    = YES;
    //距离
    request.radius=[rangRadius.text doubleValue];
    //默认取回第一个页
    request.page=curPage;
    //每页多少
    request.offset=20;
    /* 添加搜索结果过滤 */
    //AMapPlaceSearchFilter *filter = [[AMapPlaceSearchFilter alloc] init];
    //filter.costFilter = @[@"100", @"200"];
    //filter.requireFilter = AMapRequireGroupbuy;
    //request.searchFilter = filter;
    
    [self.search AMapPlaceSearch:request];
}

@end
