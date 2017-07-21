//
//  KTLBNavigationController.h
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewInitRuntimeController.h"
#import "BSUIFrameworkHeader.h"
@interface KTLBNavigationController : BSUITableViewInitRuntimeController<NavigationProcess>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@end
