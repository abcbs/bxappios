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
    //平移
    IBOutlet UISwitch *gestureScorllction;
    
    //伸缩
    IBOutlet UISwitch *gestureZoomAction;
    
    //旋转开关
    IBOutlet UISwitch *gestureRotateSwitch;
    
    //翻转开关
    IBOutlet UISwitch *gestureCameraSwitch;
    
    
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
    
    //地图UI控制，比例尺
    IBOutlet UIButton *zoomLevelAction;
    
    IBOutlet UIButton *rotatedegreeAction;
    
    IBOutlet UIButton *overlookdegreeAction;
    
    //地址检索功能，POI功能
    //所在城市
    IBOutlet UITextField *cityText;
    
    //查询地址
    IBOutlet UITextField *addressText;
    
    //检索关键字的SearchBar
    
    IBOutlet UISearchBar *addressSearchBar;
    
    //经度
    IBOutlet UITextField *longitudeText;
    
    //纬度
    IBOutlet UITextField *latitudeText;
    
    //获取经纬度
    IBOutlet UIButton *geoAction;
    
    //通过经纬度获得地址
    IBOutlet UIButton *revGeoAction;
    
    //查找访问
    IBOutlet UITextField *rangRadius;
    
    //查询关键字
    IBOutlet UITextField *keyText;
    
    //关键字查找开始
    IBOutlet UIButton *poiFindAction;
    
    //查找下一组数据
    IBOutlet UIButton *poiNextAction;
    
    //保存查询结果
    IBOutlet UIButton *poiSaveAction;
    
    //收藏POI
    IBOutlet UIButton *favSave;
    
    //查看收藏
    IBOutlet UIButton *favBrowser;
    
    //取消收藏
    IBOutlet UIButton *favDelete;
    
    //路线规划
    //终点城市
    IBOutlet UITextField *endCityText;
    
    //终点地址
    IBOutlet UITextField *endAddressText;
    //线路规划查询的Search Bar
    IBOutlet UISearchBar *endAddressSearchBar;
    
    //搜索按钮
    
    IBOutlet UITableView *tableView;
    
    //公交
    IBOutlet UIButton *routeByBusAction;
    
    //自驾
    IBOutlet UIButton *routeBySelfDriving;
    
    //徒步前往
    IBOutlet UIButton *routteByTrampAction;
    
    //自行车前往
    IBOutlet UIButton *routeByBikeAction;
    
    //共享，按照地址
    IBOutlet UIButton *addressSharedAction;
    
    //共享，按照经纬度
    IBOutlet UIButton *geoSharedAction;
    
    //查看共享URL
    IBOutlet UIButton *browseUrlAction;
    
    
    
}

//导航栏中显示和隐藏地图控制区域
- (IBAction)hideControllerClick:(id)sender;

- (IBAction)zoomLevelClick:(id)sender;

- (IBAction)rotatedegreeClick:(id)sender;


- (IBAction)overlookdegreeClick:(id)sender;

- (IBAction)snapCaptureClick:(id)sender;

- (IBAction)snapSaveClick:(id)sender;

//关键字或者周边查找
//当坐标不为空时，默认进入周边查找
- (IBAction)poiFindClick:(id)sender;

//POI下一页
- (IBAction)poiNextPageClick:(id)sender;

- (IBAction)poiResultSave:(id)sender;

//收藏
@property (strong, nonatomic) IBOutlet UIButton *favClick;

//查找收藏
@property (strong, nonatomic) IBOutlet UIButton *favBrowserClick;

//删除收藏
@property (strong, nonatomic) IBOutlet UIButton *favDelete;


@end
