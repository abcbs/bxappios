//
//  BSTableViewRefresh.h
//  KTAPP
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "BSTableList.h"

@interface BSTableViewRefresh : UITableViewController<BSTableList>

@property (nonatomic, retain) MBProgressHUD *HUD;

@property (nonatomic,retain)  NSMutableArray *dataTable;

@end
