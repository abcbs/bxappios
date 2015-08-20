//
//  BSTableViewRefresh.h
//  KTAPP
//  上拉更新下拉下载实现基类
//  实例,送水列表TableViewController
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSUIFrameworkHeader.h"
#import "BSTableListProtocol.h"

@interface BSTableViewRefreshController : UITableViewController<BSTableListProtocol,MBProgressHUDDelegate,NavigationProcess>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@property (nonatomic,retain) NSString *inform;

@property (nonatomic,retain)BSTableContentObject * bsContentObject;

@property (nonatomic, retain) MBProgressHUD *HUD;

@property (nonatomic,retain)  NSMutableArray *dataTable;

@property (retain, nonatomic) UILabel *errorInfo;

@end
