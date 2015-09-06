//
//  BSBaiduViewController.m
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSBaiduViewController.h"
#import "BSCMFrameworkHeader.h"

@interface BSBaiduViewController ()<UITextFieldDelegate>{
    //经纬度
    bool isGeoSearch;
}
@end

@implementation BSBaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];
    [self addCustomGestures];//添加自定义的手势
    self.segment.selectedSegmentIndex = 0;
    [_mapView setTrafficEnabled:NO];
    [_mapView setBuildingsEnabled:YES];
    
    [_mapView setBaiduHeatMapEnabled:NO];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    _poisearch = [[BMKPoiSearch alloc]init];
    
    _suggestionsearch =[[BMKSuggestionSearch alloc]init];
   
    _shareurlsearch = [[BMKShareURLSearch alloc]init];

    [_mapView setZoomLevel:16];

    //
    _nextPageButton.enabled = false;
    
    _mapView.isSelectedAnnotationViewFront = YES;
    
    [baseUIControllerView setHidden:YES];
    [searchUIControllerView setHidden:NO];
    [localtionUIControllerView setHidden:YES];
    //定位
    _locService = [[BMKLocationService alloc]init];
    [followHeadBtn setEnabled:NO];
    [followingBtn setAlpha:0.6];
    [followingBtn setEnabled:NO];
    [followHeadBtn setAlpha:0.6];
    [stopBtn setEnabled:NO];
    [stopBtn setAlpha:0.6];
    
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    //切换为普通地图
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
     _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
     _suggestionsearch.delegate = self;
     _locService.delegate = self;
    [self initSubViews];
    [self hideController];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _poisearch.delegate=nil;
    _suggestionsearch.delegate =nil;
    _shareurlsearch.delegate=nil;
     _locService.delegate = nil;
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_poisearch!=nil) {
        _poisearch=nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_suggestionsearch) {
        _suggestionsearch=nil;
    }
    if (_shareurlsearch) {
        _shareurlsearch=nil;
    }
    if (_locService) {
        _locService=nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)initSubViews
{
    //修改样式
    //登陆按钮
    //[BSUIComponentView configButtonStyle:_closeButton];
    controllerView.hidden=YES;

    
}

-(void)delelageForTextField{
     //旋转度
    _rotatedegree.delegate=self;
    
    //收缩
    _zoomdegree.delegate=self;
    
    //俯视度
    _overlookdegree.delegate=self;
    
    //
    _coordinateXText.delegate=self;
    _coordinateYText.delegate=self;
    _cityText.delegate=self;
    _addrText.delegate=self;
    
    //POI查找
    _poiCityText.delegate=self;
    _keyText.delegate=self;
   
    
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)zoomButtonClicked:(id)sender
{
    // 地图比例尺级别，在手机上当前可使用的级别为3-19级
    _mapView.zoomLevel = [_zoomdegree.text floatValue];
    
}
- (IBAction)rotateButtonClicked:(id)sender
{
    //地图旋转角度，在手机上当前可使用的范围为－180～180度
    _mapView.rotation = [_rotatedegree.text floatValue];
}
- (IBAction)overlookButtonClicked:(id)sender
{
    //地图俯视角度，在手机上当前可使用的范围为－45～0度
    _mapView.overlooking = [_overlookdegree.text floatValue];
}

#pragma mark - BMKMapViewDelegate
#pragma mark 底图手势操作
/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    NSLog(@"onClickedMapPoi-%@",mapPoi.text);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", mapPoi.text,mapPoi.pt.longitude,mapPoi.pt.latitude, (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
    _addrText.text=mapPoi.text;
    //_cityText.text=mapPoi.text;
   
    _coordinateYText.text=[NSString stringWithFormat:@"%f",mapPoi.pt.latitude];
    _coordinateXText.text=[NSString stringWithFormat:@"%f",mapPoi.pt.longitude];
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onDoubleClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您双击了地图(double click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
    
    _coordinateXText.text = [NSString stringWithFormat:@"%f",
                             coordinate.longitude];//纬度
    
    _coordinateYText.text = [NSString stringWithFormat:@"%f",
                             coordinate.latitude];//经度
}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onLongClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您长按了地图(long pressed).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
    _coordinateXText.text = [NSString stringWithFormat:@"%f",
                            coordinate.longitude];//纬度
    
    _coordinateYText.text = [NSString stringWithFormat:@"%f",
                             coordinate.latitude];//经度

    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSString* showmeg = [NSString stringWithFormat:@"地图区域发生了变化(x=%d,y=%d,\r\nwidth=%d,height=%d).\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d",(int)_mapView.visibleMapRect.origin.x,(int)_mapView.visibleMapRect.origin.y,(int)_mapView.visibleMapRect.size.width,(int)_mapView.visibleMapRect.size.height,(int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    
    _showMsgLabel.text = showmeg;
    
    
}


- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    BSLog(@"地图初始化完成");
}



#pragma mark - 添加自定义的手势（若不自定义手势，不需要下面的代码）

- (void)addCustomGestures {
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    BSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    BSLog(@"my handleDoubleTap");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeMapType:(id)sender {
    
    NSInteger index = self.segment.selectedSegmentIndex;
    switch (index) {
        case 0://标准地图
            _mapView.mapType = BMKMapTypeStandard;
            break;
        case 1://卫星地图
            _mapView.mapType = BMKMapTypeSatellite;
            break;
        default:
            break;
    }

}

- (IBAction)changeControllerType:(id)sender {
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

- (IBAction)switchValueChanged:(id)sender {
    UISwitch *switchControl = (UISwitch*)sender;
    BOOL isOn = switchControl.isOn;
    switch (switchControl.tag) {
        case 0:
            [_mapView setTrafficEnabled:isOn];
            break;
            
        case 1:
            [_mapView setBuildingsEnabled:isOn];
            break;
            
        case 2:
            [_mapView setBaiduHeatMapEnabled:isOn];
            break;
            
        default:
            break;
    }

}

- (IBAction)snapshot:(id)sender {
    //mapView
    _hiddenView.hidden = false;
    _closeButton.enabled=YES;
    _snopImageButton.enabled=NO;
    [self.mapView bringSubviewToFront:_hiddenView];
    //获得地图当前可视区域截图
    _imgView.image = [_mapView takeSnapshot];
    //_closeButton.frame=BSRectMake(115, 340, _closeButton.frame.size.width, _closeButton.frame.size.height);
    
    //controllerView.hidden=YES;
    [_hiddenView bringSubviewToFront:_closeButton];
    self.navigationItem.rightBarButtonItem.enabled = false;

}

//截图页面的关闭按钮
- (IBAction)closeButtonClicked:(id)sender;
{
    //关闭截图
    _hiddenView.hidden = true;
    _snopImageButton.enabled=YES;
    _closeButton.enabled=NO;
    [self.mapView sendSubviewToBack:_hiddenView];
    _imgView.image = nil;
    self.navigationItem.rightBarButtonItem.enabled = true;
    //如果控制区域为隐藏则继续保持隐藏属性
    controllerView.hidden=controllerView.hidden;
    
}

- (IBAction)hideControllerClick:(id)sender {
    controllerView.hidden=YES;
    [self hideController];
}

-(void)hideController{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"显示控制" style:UIBarButtonItemStylePlain target:self action:@selector(displayControllerView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];

}
-(void)displayControllerView{
    controllerView.hidden=NO;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"隐藏控制" style:UIBarButtonItemStylePlain target:self action:@selector(hideControllerClick:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];

}

#pragma mark 底图手势开关

- (IBAction)zoomSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.zoomEnabled = [tempSwitch isOn];
}

- (IBAction)moveSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.scrollEnabled = [tempSwitch isOn];
}

- (IBAction)scaleSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.showMapScaleBar = [tempSwitch isOn];
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 40);
}

#pragma mark -地图定位
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    return annotationView;
}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        //设置经纬度输入框的值
       _coordinateXText.text = [NSString stringWithFormat:@"%f",item.coordinate.longitude];//纬度
        
        _coordinateYText.text = [NSString stringWithFormat:@"%f",item.coordinate.latitude];//经度

        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        _cityText.text=result.addressDetail.city;
        
        //返回的兴趣点
        NSArray *pioResult=result.poiList;
        if (pioResult.count>0) {
            BMKPoiInfo* pioInfo=pioResult[0];
            _addrText.text=pioInfo.name;
            showmeg = [NSString stringWithFormat:@"名称:%@\t%@",pioInfo.name,item.title];

        }
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}
#pragma mark -地图
-(IBAction)onClickReverseGeocode
{
    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
        pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

-(IBAction)onClickGeocode
{
    isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityText.text;
    geocodeSearchOption.address = _addrText.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}

//点击地址编辑弹出提示信息
- (IBAction)onEditingChangedAddredss:(id)sender {
    
}


-(IBAction)onClickOk{
    //如果有兴趣点
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    curPage = 0;
    if ([_keyText.text isEqualToString:@""]) {
        [self searchByBMKCitySearchOption];
    }else{
         [self searchByBMKNearbySearchOption];
    }
}

-(IBAction)onClickNextPage{
    curPage++;
    if ([_keyText.text isEqualToString:@""]) {
        [self searchByBMKCitySearchOption];
    }else{
        [self searchByBMKNearbySearchOption];
    }
}

-(void)searchByBMKNearbySearchOption{
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = curPage;
    option.pageCapacity = 100;
    option.radius=500;
    option.location = (CLLocationCoordinate2D){[_coordinateYText.text doubleValue], [_coordinateXText.text doubleValue]};
    //CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    option.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchNearBy:option];
    if(flag)
    {
        _nextPageButton.enabled = true;
        _savePOIButton.enabled=true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        _savePOIButton.enabled=false;
        NSLog(@"城市内检索发送失败");
    }

}

-(void)searchByBMKCitySearchOption{
    //curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 100;
    //
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _addrText.text;

    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextPageButton.enabled = true;
        _savePOIButton.enabled=true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        _savePOIButton.enabled=false;
        NSLog(@"城市内检索发送失败");
    }

    
}

-(void)searchByBMKPoiDetailSearchOption:(NSString *)uid{
    //初始化检索服务
    //POI详情检索
    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
    option.poiUid = uid;//POI搜索结果中获取的uid
    BOOL flag = [_poisearch poiDetailSearch:option];
    if(flag)
    {
        //详情检索发起成功
    }
    else
    {
        //详情检索发送失败
    }
}
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            item.subtitle=[NSString stringWithFormat:@"电话:%@地址:%@",poi.phone,poi.address];
            [self searchByBMKPoiDetailSearchOption:poi.uid];
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    /**
     NSString* name;
     CLLocationCoordinate2D pt;
     NSString* address;
     NSString* phone;
     NSString* uid;
     NSString* tag;
     NSString* detailUrl;
     NSString* type;
     double  price;
     double overallRating;
     double asteRating;
     double serviceRating;
     double environmentRating;
     double facilityRating;
     double hygieneRating;
     double technologyRating;
     int imageNum;
     int grouponNum;
     int commentNum;
     int favoriteNum;
     int checkInNum;
     NSString* _shopHours;

     */
    if(errorCode == BMK_SEARCH_NO_ERROR){
        BSLog(@"详细信息:分类\t%@\t名称:%@\t电话:%@\tURL:%@\t价格:%f营业时间:%@",poiDetailResult.tag,
              poiDetailResult.name,poiDetailResult.address,poiDetailResult.detailUrl
              ,poiDetailResult.price,poiDetailResult.shopHours);
    }
}

//建议检索
//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//短URL
-(IBAction)poiShortUrlShare{
    
}
-(IBAction)reverseGeoShortUrlShare{
    
}

//收藏
- (IBAction)saveAction:(id)sender{
    
}

- (IBAction)getAllAction:(id)sender{
    
}

- (IBAction)deleteAllAction:(id)sender{
    
}

- (IBAction)updateCancelAction:(id)sender{
    
}

- (IBAction)updateSaveAction:(id)sender{
    
}


//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    // [_mapView setZoomLevel:14];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [startBtn setEnabled:NO];
    [startBtn setAlpha:0.6];
    [stopBtn setEnabled:YES];
    [stopBtn setAlpha:1.0];
    [followHeadBtn setEnabled:YES];
    [followHeadBtn setAlpha:1.0];
    [followingBtn setEnabled:YES];
    [followingBtn setAlpha:1.0];
}
//罗盘态
-(IBAction)startFollowHeading:(id)sender
{
    NSLog(@"进入罗盘态");
    // [_mapView setZoomLevel:14];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(IBAction)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    // [_mapView setZoomLevel:14];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
-(IBAction)stopLocation:(id)sender
{
    // [_mapView setZoomLevel:14];
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    [stopBtn setEnabled:NO];
    [stopBtn setAlpha:0.6];
    [followHeadBtn setEnabled:NO];
    [followHeadBtn setAlpha:0.6];
    [followingBtn setEnabled:NO];
    [followingBtn setAlpha:0.6];
    [startBtn setEnabled:YES];
    [startBtn setAlpha:1.0];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", userLocation.title,
                         userLocation.location.coordinate.longitude ,userLocation.location.coordinate.latitude, (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
    //_addrText.text=mapPoi.text;
    _coordinateYText.text=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    _coordinateXText.text=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


@end
