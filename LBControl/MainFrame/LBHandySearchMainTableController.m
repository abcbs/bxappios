//
//  LBHandySearchMainTableController.m
//  KTAPP
//
//  Created by admin on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LBHandySearchMainTableController.h"

@implementation LBHandySearchMainTableController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *覆盖父类实现，不显示章节标题
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
@end
