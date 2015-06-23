//
//  BSTableViewRefresh.m
//  KTAPP
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableViewRefresh.h"

#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "Conf.h"



@implementation BSTableViewRefresh

@synthesize HUD;
@synthesize dataTable;


- (void)viewDidLoad {
    if(!HUD){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        //如果设置此属性则当前的view置于后台
        //_HUD.dimBackground = YES;
        HUD.mode = MBProgressHUDModeDeterminate;
        //设置对话框文字
        HUD.labelText = @"请稍等";
    }
    [self setupRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WATER_LIST_ROW_HIGH;
}

//1.懒加载
-(NSMutableArray *)dataTable
{
    if (!dataTable)
        dataTable = [NSMutableArray array];
    
    return dataTable;
}

- (void)dealloc
{
    NSLog(@"TableView dealloc");
    [self.tableView removeHeader ];
    
    [self.tableView removeFooter];
    [HUD removeFromSuperview];
    HUD = nil;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addLegendHeaderWithRefreshingTarget:self
                                       refreshingAction:@selector(headerRereshing)];
    self.tableView.header.updatedTimeHidden = YES;
    [self.tableView.header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addLegendFooterWithRefreshingTarget:self
                                       refreshingAction:@selector(footerRereshing)];
    [self.tableView.footer setTitle:@"已经是最后一条"
                           forState:MJRefreshFooterStateNoMoreData];
}

#pragma mark 列表下拉下载上拉更新需实现的方法
- (void)loadMoreData:(long) warterId dataCount:(int)cellCount
{
    
}

- (void)headerRereshing
{
    
       
}

- (void)footerRereshing
{
    
    
}

-(int )pageCount{
    return CONTENT_HIGH/WATER_LIST_ROW_HIGH+2;
}

-(long )firstDataId{
    return 0;
}

-(long )lastDataId{
    return 0;
}

@end
