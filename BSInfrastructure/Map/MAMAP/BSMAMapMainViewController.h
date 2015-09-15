//
//  BSMAMapMainViewController.h
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSIFTTHeader.h"
#import "BaseMapViewController.h"


@interface BSMAMapMainViewController : BaseMapViewController{
    
    IBOutlet UIView *baseUIControllerView;
    
    //查询与POI控制区
    IBOutlet UIView *searchUIControllerView;
    
    //定位与检索
    IBOutlet UIView *localtionUIControllerView;
    
    //地图控制域
    IBOutlet UIView *mapControllerView;
    
    IBOutlet UILabel* _showMsgLabel;
    
    //控制器段显示
    IBOutlet UISegmentedControl *controllerSegmented;
    
    //卫星与标准显示图像
    IBOutlet UISegmentedControl *mapTypeSegmentedControl;
    
    //截图，屏幕快照
     IBOutlet UIButton *screenShotAction;
    
    //保存快照
    IBOutlet UIButton *saveScreenShotAction;
    
    //交通路况
    IBOutlet UISwitch *trafficSwitch;
    
    //定位开关
    IBOutlet UISegmentedControl *showUserLocationSegment;
    
    //定位跟踪
    IBOutlet UISegmentedControl *modeUserLocationSegment;
    //楼宇、地面物
    
    //手势UISwitch
    IBOutlet UISwitch *gestureScorllction;
    
    
    IBOutlet UISwitch *gestureZoomAction;
    
    //比例尺
    IBOutlet UISwitch *levelAction;
    
    //双击手势
    IBOutlet UITapGestureRecognizer *doubleTap;
    
    //单击手势
    IBOutlet UITapGestureRecognizer *singleTap;
    
    //地图显示级别
    
    IBOutlet UITextField *zoomdegree;
    
    //旋转度
    IBOutlet UITextField *rotatedegree;
    
    //俯视度
    IBOutlet UITextField *overlookdegree;
    //
    
    IBOutlet UIButton *zoomLevelAction;
    
    IBOutlet UIButton *rotatedegreeAction;
    
    IBOutlet UIButton *overlookdegreeAction;
}

//导航栏中显示和隐藏地图控制区域
- (IBAction)hideControllerClick:(id)sender;

- (IBAction)zoomLevelClick:(id)sender;

- (IBAction)rotatedegreeClick:(id)sender;


- (IBAction)overlookdegreeClick:(id)sender;

- (IBAction)snapCaptureClick:(id)sender;


@end
