//
//  BSUITableViewInitRuntimeController.h
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTableObject.h"


@interface BSUITableViewInitRuntimeController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *bSTableObjects;

//@property (nonatomic, strong) UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
