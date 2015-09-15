//
//  BSMAMapMainViewController.m
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSMAMapMainViewController.h"
#import "BSIFTTHeader.h"

@interface BSMAMapMainViewController ()<UIGestureRecognizerDelegate>


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

@property (nonatomic) BOOL started;
//
@end

@implementation BSMAMapMainViewController
@synthesize tip       = _tip;

@synthesize pan        = _pan;
@synthesize shapeLayer = _shapeLayer;
@synthesize started    = _started;

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

#pragma mark -继承父类方法对视图格式化
-(void)initSubViews{
    
    [BSUIComponentView configButtonStyle:screenShotAction];
    [BSUIComponentView configButtonStyle:saveScreenShotAction];
    [BSUIComponentView configButtonStyle:zoomLevelAction];
    [BSUIComponentView configButtonStyle:rotatedegreeAction];
    [BSUIComponentView configButtonStyle:overlookdegreeAction];
    mapControllerView.hidden=YES;
    //显示控制区域
    [controllerSegmented addTarget:self action:@selector(changeControllerType:) forControlEvents:UIControlEventValueChanged];
    
    //默认情况
    [baseUIControllerView setHidden:YES];
    [localtionUIControllerView setHidden:YES];
    [searchUIControllerView setHidden:NO];
    controllerSegmented.selectedSegmentIndex=1;
    
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
    
    //手势
    // 需要额外添加一个双击手势，以避免当执行mapView的双击动作时响应两次单击手势。
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
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
    
    //[self startupAction];
    
    //captureAction[self.mapView addAnnotation:self.pointAnnotation];
    //[self.mapView addOverlay:self.circle];
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

#pragma mark 继承父类方法，键盘处理事件
-(void)delelageForTextField{
    
    //比例
    zoomdegree.delegate=self;
    
    //旋转度
    rotatedegree.delegate=self;
    
    //俯视度
    overlookdegree.delegate=self;
    
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
    
}

- (IBAction)snapCaptureClick:(id)sender {
    //[self captureAction];
    [self startupAction];
}


- (IBAction)zoomLevelClick:(id)sender {
    [self.mapView setZoomLevel:[zoomdegree.text floatValue] animated:YES];
    
}

- (IBAction)rotatedegreeClick:(id)sender {
}

//手势移动
- (void)gestureZoomAction:(UISwitch *)switcher{
     self.mapView.scrollEnabled = switcher.on;
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
    
    UIImage *screenshotImage = [self.mapView takeSnapshotInRect:inRect];
    
    [self transitionToDetailWithImage:screenshotImage];
}

- (void)startupAction
{
    self.started = !self.started;
    
    //self.navigationItem.rightBarButtonItem.title = StartupTitle(self.started);
    
    //[self.navigationController setToolbarHidden:!self.started animated:YES];
    
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

- (void)transitionToDetailWithImage:(UIImage *)image
{
    BSLog(@"调转到快照界面");
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 4;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        
        return circleRenderer;
    }
    
    return nil;
}


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
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"userPosition"];
        pre.lineWidth = 3;
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
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



@end
