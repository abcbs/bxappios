//
//  WayPointRouteSearchDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 13-7-14.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "WayPointRouteSearchViewController.h"
#import "UIImage+Rotate.h"
#import "PromptInfo.h"
#import "BSCMFrameworkHeader.h"

#import "FunctionView.h"
#import "ImageModelClass.h"
#import "ToolView.h"
#import "MoreView.h"
#import "HistoryImage.h"


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@interface WayPointRouteSearchViewController (){
    int keyboardhight;
    
}

//自定义组件
@property (nonatomic, strong) ToolView *toolView;

@property (nonatomic, strong) FunctionView *functionView;

@property (nonatomic, strong) MoreView *moreView;

//系统组件
@property (strong, nonatomic) IBOutlet UITextView *myTextView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *sendString;

//数据model
@property (strong, nonatomic) ImageModelClass  *imageMode;

@property (strong, nonatomic)HistoryImage *tempImage;

@property (strong, nonatomic) NSDictionary * keyBoardDic;

@end

@implementation WayPointRouteSearchViewController


- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _routesearch = [[BMKRouteSearch alloc]init];
    //初始化检索对象
    _searchersuggestionSearch =[[BMKSuggestionSearch alloc]init];
    //_suggestionSearch.delegate = self;
    //[self keyboardConfigure];
    _startAddrText.inputAccessoryView =[self keyboardToolBar];
    _endAddrText.inputAccessoryView =[self keyboardToolBar];
    _wayPointAddrText.inputAccessoryView =[self keyboardToolBar];
}

-(void)keyboardConfigure{
    //从sqlite中读取数据
    self.imageMode = [[ImageModelClass alloc] init];
    //实例化FunctionView
    self.functionView = [[FunctionView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    self.functionView.backgroundColor = [UIColor blackColor];
    
    //设置资源加载的文件名
    self.functionView.plistFileName = @"emoticons";
    
    __weak __block WayPointRouteSearchViewController *copy_self = self;
    //获取图片并显示
    [self.functionView setFunctionBlock:^(UIImage *image, NSString *imageText)
     {
         NSString *str = [NSString stringWithFormat:@"%@%@",copy_self.myTextView.text, imageText];
         
         copy_self.myTextView.text = str;
         copy_self.imageView.image = image;
         //把使用过的图片存入sqlite
         NSData *imageData = UIImagePNGRepresentation(image);
         [copy_self.imageMode save:imageData ImageText:imageText];
     }];
    
    
    //实例化MoreView
    self.moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.moreView.backgroundColor = [UIColor blackColor];
    
    //进行ToolView的实例化
    self.toolView = [[ToolView alloc] initWithFrame:CGRectZero];
    self.toolView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.toolView];
    
    //给ToolView添加约束
    //开启自动布局
    self.toolView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //水平约束
    NSArray *toolHConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolView)];
    [self.view addConstraints:toolHConstraint];
    
    //垂直约束
    NSArray *toolVConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolView(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolView)];
    
    [self.view addConstraints:toolVConstraint];
    
    //回调toolView中的方法
    
    [self.toolView setToolIndex:^(NSInteger index)
     {
         NSLog(@"%ld", (long)index);
         
         switch (index) {
             case 1:
                 [copy_self changeKeyboardToFunction];
                 break;
                 
             case 2:
                 [copy_self changeKeyboardToFunction];
                 break;
                 
             default:
                 break;
         }
     }];
     //
    [self.moreView setMoreBlock:^(NSInteger index) {
        NSLog(@"MoreIndex = %ld",(long)index);
    }];
}


-(void) keyNotification : (NSNotification *) notification
{
    NSLog(@"%@", notification.userInfo);
    
    self.keyBoardDic = notification.userInfo;
    //获取键盘移动后的坐标点的坐标点
    CGRect rect = [self.keyBoardDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    //把键盘的坐标系改成当前我们window的坐标系
    CGRect r1 = [self.view convertRect:rect fromView:self.view.window];
    
     [UIView animateWithDuration:[self.keyBoardDic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
     CGRect frame = self.toolView.frame;
     
     frame.origin.y = r1.origin.y - frame.size.height;
     
     //根据键盘的高度来改变toolView的高度
     self.toolView.frame = frame;
     }];
     
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //纵屏
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        CGRect frame = self.functionView.frame;
        frame.size.height = 216;
        self.functionView.frame = frame;
        self.moreView.frame = frame;
        
    }
    //横屏
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect frame = self.functionView.frame;
        frame.size.height = 150;
        self.functionView.frame = frame;
        self.moreView.frame = frame;
    }
}

#pragma mark -键盘事件
-(void)keyboardDone:(id)sender{
    
    //BMKSuggestionSearch
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = @"北京";
    option.keyword  = @"中关村";
    BOOL flag = [_searchersuggestionSearch suggestionSearch:option];
    //[option release];
    if(flag)
    {
        BSLog(@"建议检索发送成功");
    }
    else
    {
        BSLog(@"建议检索发送失败");
        [PromptInfo showText:@"建议检索发送失败"];
    }
}

#pragma mark -以代理BSUIKeyboardCoViewDelegate实现的具体事件
- (IBAction)keyAction:(id)sender {
    [PromptInfo showText:@"确定查询-多Button实现"];
}
//键盘增加多Button
//切换键盘的方法
-(void) changeKeyboardToFunction
{
    if ([self.myTextView.inputView isEqual:self.functionView])
    {
        self.myTextView.inputView = nil;
        [self.myTextView reloadInputViews];
    }
    else
    {
        self.myTextView.inputView = self.functionView;
        [self.myTextView reloadInputViews];
    }
    
    if (![self.myTextView isFirstResponder])
    {
        [self.myTextView becomeFirstResponder];
    }
}

-(void) changeKeyboardToMore{
    if ([self.myTextView.inputView isEqual:self.functionView])
    {
        self.myTextView.inputView = nil;
        [self.myTextView reloadInputViews];
    }
    else
    {
        self.myTextView.inputView = self.functionView;
        [self.myTextView reloadInputViews];
    }
    
    if (![self.myTextView isFirstResponder])
    {
        [self.myTextView becomeFirstResponder];
    }
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _searchersuggestionSearch.delegate = self;
     
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil; // 不用时，置nil
    _searchersuggestionSearch.delegate = nil;

}

- (void) dealloc{
    //Unregister notifications
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    //[_searchersuggestionSearch
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
        }
            break;
		default:
			break;
	}
	
	return view;
}

#pragma mark -百度地图建议查询
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
		int size = [plan.steps count];
		int planPointCounts = 0;
		for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
		[_mapView addOverlay:polyLine]; // 添加路线overlay
		delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
	}else if (error==BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //BMK_SEARCH_AMBIGUOUS_ROURE_ADDR,///<检索地址有岐义
         [PromptInfo showText:@"检索地址有岐义"];
    }else if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
         [PromptInfo showText:@"检索地址有岐义"];
    
    }else if (error==BMK_SEARCH_NOT_SUPPORT_BUS){
        //BMK_SEARCH_NOT_SUPPORT_BUS,///<该城市不支持公交搜索
        [PromptInfo showText:@"该城市不支持公交搜索"];
    }else if (error== BMK_SEARCH_NOT_SUPPORT_BUS_2CITY){
       //BMK_SEARCH_NOT_SUPPORT_BUS_2CITY,///<不支持跨城市公交
        [PromptInfo showText:@"不支持跨城市公交"];
    }else if (error==BMK_SEARCH_RESULT_NOT_FOUND){
       ///<没有找到检索结果
      [PromptInfo showText:@"没有找到检索结果"];
    }else if (error==BMK_SEARCH_ST_EN_TOO_NEAR){
       ///BMK_SEARCH_ST_EN_TOO_NEAR,///<起终点太近
       [PromptInfo showText:@"起终点太近"];
    }else if (error==BMK_SEARCH_KEY_ERROR){
       ///BMK_SEARCH_KEY_ERROR,///<key错误
    }else if (error==BMK_SEARCH_PERMISSION_UNFINISHED){
       //BMK_SEARCH_PERMISSION_UNFINISHED,///还未完成鉴权，请在鉴权通过后重试
    }else if (error==BMK_SEARCH_NETWOKR_ERROR||error==BMK_SEARCH_NETWOKR_TIMEOUT){
       // BMK_SEARCH_NETWOKR_ERROR,///网络连接错误
       // BMK_SEARCH_NETWOKR_TIMEOUT,///网络连接超时
       [PromptInfo showText:@"网络连接错误/网络连接超时"];
    }    
    
}

-(IBAction)onDriveSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.name = _startAddrText.text;
    start.cityName =_cityText.text;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText.text;
    if ([_endCityText.text isEqualToString:@""]) {
        end.cityName = _cityText.text;
    }else{
        end.cityName = _endCityText.text;
    }
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10];
    BMKPlanNode* wayPointItem1 = [[BMKPlanNode alloc]init];
    
    if ([_wayPointCity.text isEqualToString:@""]) {
        wayPointItem1.cityName = _cityText.text;
    }else{
        wayPointItem1.cityName = _wayPointCity.text;
    }

    wayPointItem1.name = _wayPointAddrText.text;
    [array addObject:wayPointItem1];
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    drivingRouteSearchOption.wayPointsArray = array;
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"search success.");
    }
    else
    {
        NSLog(@"search failed!");
    }
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

-(void)delelageForTextField{
        
     _startAddrText.delegate=self;
    
    _wayPointAddrText.delegate=self;
    
    _wayPointCity.delegate=self;
    
    
    _endAddrText.delegate=self;
    
    _endCityText.delegate=self;
    
    
    _cityText.delegate=self;
}

#pragma mark - Rotation control-以代理方式需要实现的方法，这种方法可以实现多个普通的按钮
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewWillRotateNotification object:nil];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewDidRotateNotification object:nil];
}
@end
