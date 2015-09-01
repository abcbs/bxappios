//
//  BSBaiduViewController.h
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSCMFrameworkHeader.h"

@interface BSBaiduViewController : BSUICommonController<BMKMapViewDelegate,UIGestureRecognizerDelegate>{
    
    
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
    
    //
    IBOutlet UIButton* _closeButton;
    
    IBOutlet UIImageView* _imgView;
    
    IBOutlet UIView* _hiddenView;
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


@end
