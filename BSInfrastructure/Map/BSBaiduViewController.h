//
//  BSBaiduViewController.h
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSCMFrameworkHeader.h"

@interface BSBaiduViewController : BSUICommonController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UIGestureRecognizerDelegate>{
    
    
    IBOutlet UIView *controllerView;
    //收缩
    IBOutlet UIButton *_zoom;
    
    //旋转
    IBOutlet UIButton *_rotate;
    
    //俯瞰
    IBOutlet UIButton *_overlook;
    
    //收缩度
    IBOutlet UITextField* _zoomdegree;
    
    //旋转度
    IBOutlet UITextField* _rotatedegree;
    
    //俯视度
    IBOutlet UITextField* _overlookdegree;
    
    //显示，点击、长按或双击地图以获取地图状态
    IBOutlet UILabel* _showMsgLabel;
    
    //截图按钮
    IBOutlet UIButton *_snopImageButton;
    
    //取消截图
    IBOutlet UIButton* _closeButton;
    
    IBOutlet UIImageView* _imgView;
    
    IBOutlet UIView* _hiddenView;
    
    //UI控制
    IBOutlet UISwitch *_zoomSwitch;
    
    IBOutlet UISwitch *_moveSwitch;
    
    IBOutlet UISwitch *_scaleSwith;
    
    //地图定位
    IBOutlet UITextField* _coordinateXText;
    IBOutlet UITextField* _coordinateYText;
    IBOutlet UITextField* _cityText;
    IBOutlet UITextField* _addrText;
    BMKGeoCodeSearch* _geocodesearch;
 
}


@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

- (IBAction)changeMapType:(id)sender;

- (IBAction)switchValueChanged:(id)sender;

- (IBAction)zoomButtonClicked:(id)sender;

- (IBAction)rotateButtonClicked:(id)sender;

- (IBAction)overlookButtonClicked:(id)sender;

- (IBAction)textFiledReturnEditing:(id)sender;

- (IBAction)snapshot:(id)sender;


- (IBAction)closeButtonClicked:(id)sender;

- (IBAction)hideControllerClick:(id)sender;

//UI控制操作
- (IBAction)zoomSwitchAction:(UISwitch *)sender;

- (IBAction)moveSwitchAction:(UISwitch *)sender;

- (IBAction)scaleSwitchAction:(UISwitch *)sender;

//地图定位，获取经纬度
-(IBAction)onClickGeocode;

//根据经纬度取得地址
-(IBAction)onClickReverseGeocode;


@end
