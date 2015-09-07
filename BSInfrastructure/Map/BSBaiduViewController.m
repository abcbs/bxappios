//
//  BSBaiduViewController.m
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSBaiduViewController.h"
#import "BSCMFrameworkHeader.h"
#import "PromptInfo.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MyAnimatedAnnotationView.h"

#define INDEX_TAG_DIS   1000

@interface MyFavoriteAnnotation : BMKPointAnnotation

@property (nonatomic, assign) NSInteger favIndex;
@property (nonatomic, strong) BMKFavPoiInfo *favPoiInfo;

@end

@implementation MyFavoriteAnnotation

@synthesize favIndex = _favIndex;
@synthesize favPoiInfo = _favPoiInfo;

@end
//BMKPointAnnotation
@interface MySearchAnnotation : BMKPointAnnotation

@property (nonatomic, assign) NSInteger searchIndex;
@property (nonatomic, strong) BMKPoiInfo *searchPoiInfo;

@end

@implementation MySearchAnnotation

@synthesize searchIndex = _searchIndex;
@synthesize searchPoiInfo = _searchPoiInfo;

@end

@interface BSBaiduViewController ()<UITextFieldDelegate>{
    //经纬度
    bool isGeoSearch;
    //int radius;
    BMKPointAnnotation* searchPointAnnotation;
    //当前搜索的节点
    NSMutableArray *_searchResultPoi;
    //当前搜索的节点
    NSMutableArray *_searchResultAnn;
    //当前搜索点
    //从地址翻译为经纬度时是否显示提示框，默认显示
    BOOL isShowCoordInfo;
    //收藏
    BMKFavPoiManager *_favManager;

    NSInteger _curFavIndex;
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
    
    //收藏
    _favManager = [[BMKFavPoiManager alloc] init];
    
    //
    [_mapView setZoomLevel:16];

    //周边查找时，设置周边的默认距离
    //radius=500;
    _nextPageButton.enabled = false;
    
    //查询结果存放值
    _searchResultPoi=[[NSMutableArray alloc]init];
    _searchResultAnn=[[NSMutableArray alloc]init];
    
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
    if (_favManager ) {
        _favManager = nil;
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
    _radiosText.delegate=self;
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
    BSLog(@"onClickedMapPoi-%@",mapPoi.text);
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
    BSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
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
    BSLog(@"onDoubleClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
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
    BSLog(@"onLongClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
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

// 根据anntation生成对应的View,搜藏夹功能
- (BMKAnnotationView *)viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"FavPoiMark"];
    // 设置颜色
    annotationView.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    annotationView.animatesDrop = NO;
    // 设置可拖拽
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    
    MyFavoriteAnnotation *myAnotation = (MyFavoriteAnnotation *)annotation;
    ///添加更新按钮
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    updateButton.frame = CGRectMake(10, 0, 32, 41);
    [updateButton setTitle:@"更新" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    updateButton.tag = myAnotation.favIndex + INDEX_TAG_DIS;
     
    annotationView.leftCalloutAccessoryView = updateButton;
     
    ///添加删除按钮
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeSystem];
    delButton.frame = CGRectMake(10, 0, 32, 41);
    [delButton setTitle:@"删除" forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    delButton.tag = myAnotation.favIndex + INDEX_TAG_DIS;
    annotationView.rightCalloutAccessoryView = delButton;
    
    return annotationView;
}

//点击paopao更新按钮
- (void)updateAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSArray *_favPoiInfos= [_favManager getAllFavPois];
    _curFavIndex = button.tag - INDEX_TAG_DIS;
    if (_curFavIndex < _favPoiInfos.count) {
        BMKFavPoiInfo *favInfo = [_favPoiInfos objectAtIndex:_curFavIndex];
        _coordinateXText.text = [NSString stringWithFormat:@"%lf", favInfo.pt.latitude];
        _coordinateXText.text = [NSString stringWithFormat:@"%lf", favInfo.pt.longitude];
        _addrText.text = favInfo.poiName;
        [_addrText becomeFirstResponder];
        //
    }
}

//点击paopao删除按钮
- (void)deleteAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger favIndex = button.tag - INDEX_TAG_DIS;
    NSArray *_favPoiInfos= [_favManager getAllFavPois];
    if (favIndex < _favPoiInfos.count) {
        BMKFavPoiInfo *favInfo = [_favPoiInfos objectAtIndex:favIndex];
        if ([_favManager deleteFavPoi:favInfo.favId]) {
            //[_favPoiInfos removeObjectAtIndex:favIndex];
            [self updateMapAnnotations];
            [PromptInfo showText:@"删除成功"];
            return;
        }
    }
    [PromptInfo showText:@"删除失败"];
}

#pragma mark -百度地图标注方法
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //收藏MyFavoriteAnnotation
    if ([annotation isKindOfClass:[MyFavoriteAnnotation class]]) {
        return [self viewForAnnotation:annotation];
    }
    //画当前点
    //searchPointAnnotation
    if (annotation == searchPointAnnotation) {
        NSString *AnnotationViewID = @"AnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        return annotationView;
    }
    
    //正常的显示
    //搜索到的封装为MySearchAnnotation
    
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
    //增加处理事件
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    updateButton.frame = CGRectMake(10, 0, 32, 41);
    [updateButton setTitle:@"收藏" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updatePIOAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([annotation isKindOfClass:[MySearchAnnotation class]]) {
        MySearchAnnotation *myAnotation=annotation;
        updateButton.tag = myAnotation.searchIndex + INDEX_TAG_DIS;

    }
    //
    annotationView.leftCalloutAccessoryView = updateButton;
    
    ///添加删除按钮
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeSystem];
    delButton.frame = CGRectMake(10, 0, 32, 41);
    [delButton setTitle:@"删除" forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(deletePOIAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([annotation isKindOfClass:[MySearchAnnotation class]]) {
        MySearchAnnotation *myAnotation=annotation;
        delButton.tag = myAnotation.searchIndex + INDEX_TAG_DIS;
        
    }
    //delButton.tag = annotation. + INDEX_TAG_DIS;
    annotationView.rightCalloutAccessoryView = delButton;

    return annotationView;
}

//单点收藏
-(void)updatePIOAction:(id)sender{
    //[PromptInfo showText:@"更新成功"];
    UIButton *button = (UIButton*)sender;
    NSInteger favIndex = button.tag - INDEX_TAG_DIS;
    if (favIndex < _searchResultAnn.count) {
        MySearchAnnotation *annotation = [_searchResultAnn objectAtIndex:favIndex];
        if (annotation) {
            //[_mapView  removeAnnotation:annotation];
            BMKPoiInfo* poi=annotation.searchPoiInfo;// [_searchResultPoi objectAtIndex:0];
            [self favSinglePOI:poi];
            //[_searchResultPoi removeObjectAtIndex:favIndex];
        }
    }
    [PromptInfo showText:@"收藏成功"];
}
//点击paopao删除按钮
- (void)deletePOIAction:(id)sender {
    //UIButton *button = (UIButton*)sender;
    //NSInteger favIndex = button.tag - INDEX_TAG_DIS;
    //if (favIndex < _favPoiInfos.count) {
    //BMKPoiInfo *bmkInfo = [_searchResultPoi objectAtIndex:favIndex];
        //if () {
    //[_mapView  removeAnnotation:annotation];
    //[_searchResultPoi removeObjectAtIndex:favIndex];
            //[self updateMapAnnotations];
     [PromptInfo showText:@"删除成功"];
     return;
}
#pragma mark -添加覆盖物，即形状
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.1];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 1.0;
        
        return circleView;
    }
    return nil;
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* annotations = [NSArray arrayWithArray:_mapView.annotations];
 

    BOOL isSearchPOI=NO;
    if (annotations.count>0) {
        BMKPointAnnotation *searchPOIAnn= annotations[0];
        if ([searchPOIAnn.title isEqualToString:@"搜索位置"]) {
            isSearchPOI=YES;
            [_mapView addAnnotation:searchPOIAnn];
        }else {
            [_mapView removeAnnotations:annotations];

        }
    }else {
        [_mapView removeAnnotations:annotations];

    }
    NSArray* overlays = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeAnnotations:overlays];

    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        BSLog(@"检索数量为:%lu",(unsigned long)result.poiInfoList.count);
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [_searchResultPoi addObject:poi];//
           
            //BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            MySearchAnnotation* item = [[MySearchAnnotation alloc]init];
            item.searchIndex=[_searchResultPoi count]-1;
            item.searchPoiInfo=poi;
            item.coordinate = poi.pt;
            //item.title = poi.name;
            
            [self searchByBMKPoiDetailSearchOption:poi.uid];
            //计算同关键点的距离
            BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([_coordinateYText.text doubleValue],[_coordinateXText.text doubleValue]));
            BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(poi.pt.latitude,poi.pt.longitude));//latitude
            CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
            //距离取整数
            item.subtitle=[NSString stringWithFormat:@"电话:%@\t地址:%@",poi.phone,poi.address];
            //判断是否在搜索半径内
            //int d=[_radiosText.text intValue];
            BOOL ptInCircle = BMKCircleContainsCoordinate(CLLocationCoordinate2DMake([_coordinateYText.text doubleValue],[_coordinateXText.text doubleValue]), CLLocationCoordinate2DMake(poi.pt.latitude,poi.pt.longitude), [_radiosText.text intValue]);
            if (ptInCircle) {
                item.title=[NSString stringWithFormat:@"%@  距离:%.0f  R:是",poi.name,(double)distance];
            }else{
                item.title=[NSString stringWithFormat:@"%@  距离:%.0f  R:否",poi.name,(double)distance];
            }
            //if (ptInCircle){//仅仅检索范围内
                [annotations addObject:item];
                [_searchResultAnn addObject:item];
            //}
        }
        //添加覆盖物
        CLLocationCoordinate2D coor;
        coor.latitude = [_coordinateYText.text doubleValue];//39.915;
        coor.longitude = [_coordinateXText.text doubleValue];//116.404;
        BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:coor radius:[_radiosText.text intValue]];
        [_mapView addOverlay:circle];
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        BSLog(@"起始点有歧义");
    } else if (error == BMK_SEARCH_RESULT_NOT_FOUND){
        BSLog(@"查找结束,总共发现POI为:\t%lu",(unsigned long)_searchResultPoi.count);
        NSString *showmeg=[NSString stringWithFormat:@"查找关键字:%@\t或者在经纬度附近找%@\t发现共计:%lu条",
                            _addrText.text,_keyText.text,(unsigned long)_searchResultPoi.count];
        //showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"查询关键信息" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
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
        BSLog(@"抱歉，未找到结果");
    }
}

#pragma mark -百度地图，由地址获取经纬度
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
        if (!isShowCoordInfo) {
            showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [myAlertView show];

        }
      }
}

#pragma mark -百度地图由经纬度获取地址信息
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

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    BSLog(@"地图初始化完成");
}

#pragma mark -百度地图代理方法结束

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
    //BSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    //BSLog(@"my handleDoubleTap");
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

#pragma mark -点击事件，根据经纬度获取地理信息
-(IBAction)onClickReverseGeocode
{
    //反向
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
        BSLog(@"反geo检索发送成功");
        //把经纬度标示在地图上
        [self addPointAnnotation];
    }
    else
    {
        BSLog(@"反geo检索发送失败");
    }
    
}

#pragma mark -根据经纬度找地址
-(IBAction)onClickGeocode
{
    isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityText.text;
    geocodeSearchOption.address = _addrText.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        BSLog(@"geo检索发送成功");
        [self addPointAnnotation];
    }
    else
    {
        BSLog(@"geo检索发送失败");
    }
    
}

//添加标注
- (void)addPointAnnotation
{
    searchPointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [_coordinateYText.text floatValue];//39.915;
        coor.longitude =[_coordinateXText.text floatValue];// 116.404;
        searchPointAnnotation.coordinate = coor;
        searchPointAnnotation.title = @"搜索位置";
        searchPointAnnotation.subtitle = [NSString stringWithFormat:@"%@",_addrText.text];
    [_mapView addAnnotation:searchPointAnnotation];
}

#pragma mark -查找关键字POI的基本入口方法
-(IBAction)onClickOk{
    //首先查出经纬度
    //对话框是否显示
    isShowCoordInfo=YES;
    [self onClickGeocode];
    [_searchResultPoi removeAllObjects];
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

#pragma mark -附近查找，一个坐标点
-(void)searchByBMKNearbySearchOption{
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = curPage;
    option.pageCapacity = 100;
    option.radius=[_radiosText.text intValue];
    option.location = (CLLocationCoordinate2D){[_coordinateYText.text doubleValue], [_coordinateXText.text doubleValue]};
    //CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    option.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchNearBy:option];
    if(flag)
    {
        _nextPageButton.enabled = true;
        _savePOIButton.enabled=true;
        BSLog(@"城市内检索发送成功");
        [self addPointAnnotation];
    }
    else
    {
        _nextPageButton.enabled = false;
        _savePOIButton.enabled=false;
        BSLog(@"城市内检索发送失败");
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
        [self addPointAnnotation];
    }
    else
    {
        _nextPageButton.enabled = false;
        _savePOIButton.enabled=false;
        BSLog(@"城市内检索发送失败");
    }

    
}

#pragma mark -私有方法，获取详细POI
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

//短URL
-(IBAction)poiShortUrlShare{
    
}

-(IBAction)reverseGeoShortUrlShare{
    
}

//收藏
- (IBAction)saveAction:(id)sender{
    [self saveAction];
}

-(void)saveAction{
    if (_searchResultPoi.count<1) {
        [PromptInfo showText:@"没有要收藏的数据"];
        return;
    }
    int i=0;
    int pos=0;
   
    for (i=0; i< _searchResultPoi.count;i++ ) {
        BMKPoiInfo* poi= [_searchResultPoi objectAtIndex:i];
        [self favSinglePOI:poi];
        }//
    if (pos>0) {
        NSString *str=[NSString stringWithFormat:@"收藏的数据,共计%d条失败",pos];
        [PromptInfo showText:str];
    }else{
        NSArray *favPois = [_favManager getAllFavPois];
        NSString *str=[NSString stringWithFormat:@"收藏成功,共计%d条,当前收藏夹数量%lu",
                       i,(unsigned long)favPois.count];
        [PromptInfo showText:str];
    }
   
}

-(void)favSinglePOI:(BMKPoiInfo*) poi{
    BMKFavPoiInfo *poiInfo = [[BMKFavPoiInfo alloc] init];
    poiInfo.pt = poi.pt;
    poiInfo.poiName =poi.name;
    poiInfo.poiUid=poi.uid;
    poiInfo.address=poi.address;
    poiInfo.cityName=poi.city;
    NSInteger res = [_favManager addFavPoi:poiInfo];
    BSLog(@"数据,名称为:%@,地址为%@,\t@经度:%f,纬度:%f",poiInfo.poiName,poiInfo.address,poiInfo.pt.latitude,poiInfo.pt.longitude);
    if (res != 1) {
        //pos++;
        NSString *str=[NSString stringWithFormat:@"搜藏数据失败,名称为:%@,地址为%@",poi.name,poi.address];
        //BSLog(@"第%d条数据失败,名称为:%@,地址为%@",i,poi.name,poi.address);
        [PromptInfo showText:str];
    }
    poiInfo=nil;

}
//展现所有客户端收藏数据
- (IBAction)getAllAction:(id)sender{
    NSArray *favPois = [_favManager getAllFavPois];
    if (favPois == nil) {
        return;
    }
    //[_favPoiInfos removeAllObjects];
    //[_favPoiInfos addObjectsFromArray:favPois];
    [self updateMapAnnotations];
}

///更新地图标注
- (void)updateMapAnnotations {
    //[_mapView removeAnnotations:_mapView.annotations];
    [_mapView setZoomLevel:17];
    NSInteger index = 0;
    NSArray *_favPoiInfos= [_favManager getAllFavPois];
    NSMutableArray *annos = [NSMutableArray array];
    for (index = 0;index <_favPoiInfos.count;index++) {
        BMKFavPoiInfo *info = [_favPoiInfos objectAtIndex:index];
        MyFavoriteAnnotation *favAnnotation = [[MyFavoriteAnnotation alloc] init];
        favAnnotation.title = info.poiName;
        favAnnotation.coordinate = info.pt;
        favAnnotation.favPoiInfo = info;
        if (![annos containsObject:favAnnotation]) {
            [annos addObject:favAnnotation];
        }
        BSLog(@"第%ld条数据,名称为:%@,地址为%@,\t@经度:%f,纬度:%f",
               (long)index,info.poiName,info.address,favAnnotation.coordinate.latitude,favAnnotation.coordinate.longitude);

        
    }
    NSString *strInfo=[NSString stringWithFormat: @"从收藏中获得的标注为%ld",(long)index];
    [PromptInfo showText:strInfo];
    [_mapView addAnnotations:annos];
    [_mapView showAnnotations:annos animated:YES];
}

//
- (IBAction)deleteAllAction:(id)sender{
   //  NSMutableArray *annos = [NSMutableArray array];
    BOOL res = [_favManager clearAllFavPois];
    if (res) {
        [PromptInfo showText:@"清除成功"];
        //[_favPoiInfos removeAllObjects];
        //_mapView removeAnnotations:_mapView.annotations];
        [self updateMapAnnotations];
    } else {
        [PromptInfo showText:@"清除失败"];
    }

}


-(void) updateSaveAction{
    
}


//普通态
-(IBAction)startLocation:(id)sender
{
    BSLog(@"进入普通定位态");
     [_mapView setZoomLevel:16];
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
    BSLog(@"进入罗盘态");
    [_mapView setZoomLevel:16];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(IBAction)startFollowing:(id)sender
{
    BSLog(@"进入跟随态");
     [_mapView setZoomLevel:18];
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
    BSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    BSLog(@"heading is %@",userLocation.heading);
    
}

#pragma mark -百度地位定位API
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", userLocation.title,
                         userLocation.location.coordinate.longitude ,userLocation.location.coordinate.latitude, (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    _showMsgLabel.text = showmeg;
    _addrText.text=userLocation.title;
    _coordinateYText.text=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    _coordinateXText.text=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    BSLog(@"stop locate");
    
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    BSLog(@"location error");
}

//点击地址编辑弹出提示信息
- (IBAction)onEditingChangedAddredss:(id)sender {
    
}
@end
