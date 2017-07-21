//
//  LSBusinessProductAduitTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductAduitTableViewController.h"

@implementation LSProductAduitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload{
    //删除数据
    [super viewDidUnload];
}

- (void)dealloc{

    
}

#pragma mark --表格样式
/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(1);
}
@end
