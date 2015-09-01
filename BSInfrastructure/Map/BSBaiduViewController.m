//
//  BSBaiduViewController.m
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSBaiduViewController.h"
#import "BSCMFrameworkHeader.h"

@interface BSBaiduViewController ()<UITextFieldDelegate>
@end

@implementation BSBaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    //self.view = mapView;
    [self addCustomGestures];//添加自定义的手势
    self.segment.selectedSegmentIndex = 0;
    [_mapView setTrafficEnabled:NO];
    [_mapView setBuildingsEnabled:YES];
    
    [_mapView setBaiduHeatMapEnabled:NO];
    
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    //切换为普通地图
    [self initSubViews];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)initSubViews
{
    //修改样式
    //登陆按钮
    [BSUIComponentView configButtonStyle:_closeButton];
    
}

-(void)delelageForTextField{
     //旋转度
    _rotatedegree.delegate=self;
    
    //收缩
    _zoomdegree.delegate=self;
    
    //俯视度
    _overlookdegree.delegate=self;
   
    
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
    [self.mapView bringSubviewToFront:_hiddenView];
    //获得地图当前可视区域截图
    _imgView.image = [_mapView takeSnapshot];
    //_closeButton.frame=BSRectMake(115, 340, _closeButton.frame.size.width, _closeButton.frame.size.height);
    
    [_hiddenView bringSubviewToFront:_closeButton];
    self.navigationItem.rightBarButtonItem.enabled = false;

}

//截图页面的关闭按钮
- (IBAction)closeButtonClicked:(id)sender;
{
    //关闭截图
    _hiddenView.hidden = true;
    [self.mapView sendSubviewToBack:_hiddenView];
    _imgView.image = nil;
    self.navigationItem.rightBarButtonItem.enabled = true;
    //如果控制区域为隐藏则继续保持隐藏属性
    controllerView.hidden=controllerView.hidden;
    
}

- (IBAction)hideControllerClick:(id)sender {
    controllerView.hidden=YES;
    //CGRect frame=_mapView.frame;
    //_mapView.frame=BSRectMake(0, 0, frame.size.width, frame.size.height);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"显示控制" style:UIBarButtonItemStylePlain target:self action:@selector(displayControllerView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
}

-(void)displayControllerView{
    controllerView.hidden=NO;
    //CGRect frame=_mapView.frame;
    //_mapView.frame=BSRectMake(0, 260, frame.size.width, frame.size.height);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"隐藏控制" style:UIBarButtonItemStylePlain target:self action:@selector(hideControllerClick:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];

}
@end
