//
//  BSBaiduViewController.h
//  KTAPP
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSCMFrameworkHeader.h"
#import <BaiduMapAPI/BMapKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface BSBaiduViewController : BSUICommonController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate, BMKSuggestionSearchDelegate,BMKLocationServiceDelegate,BMKShareURLSearchDelegate,BMKRouteSearchDelegate,UIGestureRecognizerDelegate,MFMessageComposeViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>{
    
    BMKGeoCodeSearch* _geocodesearch;
    BMKPoiSearch* _poisearch;
    BMKShareURLSearch* _shareurlsearch;
    BMKSuggestionSearch *_suggestionsearch;
    BMKLocationService* _locService;
    BMKRouteSearch* _routesearch;

    IBOutlet BMKMapView *_mapView;

    IBOutlet UIView *controllerView;
    
    //基本区域
    IBOutlet UIView *baseUIControllerView;
    
    //查询与POI控制区
    IBOutlet UIView *searchUIControllerView;
    
    //定位与检索
    
    IBOutlet UIView *localtionUIControllerView;
    
    //推荐词的TableView
    IBOutlet UITableView *sugestTableView;
    
    //控制器段显示
    IBOutlet UISegmentedControl *controllerSegmented;
    
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

    //POI,兴趣点检索
    IBOutlet UITextField* _poiCityText;
    
    IBOutlet UITextField* _keyText;
    
    IBOutlet UIButton* _nextPageButton;
    
    IBOutlet UIButton *_savePOIButton;
    
    //查找距离半径
    
    IBOutlet UITextField *_radiosText;
    
    int curPage;
    
    //短URL操作
    IBOutlet UIButton* _poiShortUrlButton;
    
    IBOutlet UIButton* _reverseGeoShortUrlButton;
    
    IBOutlet UITextField *sharedShortUrl;
    
    
    IBOutlet UIButton *browseSharedShortUrlBtn;
    //定位
    IBOutlet UIButton* startBtn;
    
    IBOutlet UIButton* stopBtn;
    
    IBOutlet UIButton* followingBtn;
    
    IBOutlet UIButton* followHeadBtn;
    
    IBOutlet UISegmentedControl *_compassSeg;
    
    
    //道路规划
    IBOutlet UITextField* _endCityText;
    IBOutlet UITextField* _endAddrText;
}




@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

//默认取当前地址，也就是取值NO时为当前地址，此时检索与定位的条件均为当前手机位置
@property (assign, nonatomic) BOOL noCurrentLocation;
//选择地图类型Segmented
- (IBAction)changeMapType:(id)sender;

- (IBAction)changeControllerType:(id)sender;

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

//显示关键字
- (IBAction)onEditingChangedAddredss:(id)sender;

//POI
-(IBAction)onClickOk;

-(IBAction)onClickNextPage;

//短URL
-(IBAction)poiShortUrlShare;

-(IBAction)reverseGeoShortUrlShare;

- (IBAction)browseSharedShortUrlAction:(id)sender;


//收藏
- (IBAction)saveAction:(id)sender;

- (IBAction)getAllAction:(id)sender;

- (IBAction)deleteAllAction:(id)sender;



//定位
-(IBAction)startLocation:(id)sender;

-(IBAction)stopLocation:(id)sender;

-(IBAction)startFollowing:(id)sender;

-(IBAction)startFollowHeading:(id)sender;

//指南针位置
- (IBAction)compassSegAction:(id)sender;

//公交
-(IBAction)onClickBusSearch;

//驾车
-(IBAction)onClickDriveSearch;

//步行
-(IBAction)onClickWalkSearch;

//驾车途径
-(IBAction)onClickWayPointSearch;



@end
