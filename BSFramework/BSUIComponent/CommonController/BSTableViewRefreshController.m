//
//  BSTableViewRefresh.m
//  KTAPP
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSTableViewRefreshController.h"

#import "BSUIFrameworkHeader.h"


@interface BSTableViewRefreshController()

@property (nonatomic, retain) NSTimer *timer;

@end


@implementation BSTableViewRefreshController

@synthesize HUD;
@synthesize dataTable;
@synthesize errorInfo;

- (void)viewDidLoad {
    //改变状态来默认颜色
    [BSUIComponentView navigationHeader:self.navigationController ];
    if(!HUD){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
 
        //如果设置此属性则当前的view置于后台
        //HUD.dimBackground = YES;
        HUD.mode = MBProgressHUDModeDeterminate;
        //设置对话框文字
        HUD.labelText = @"请稍等";
        HUD.delegate = self;
        [self.view addSubview:HUD];
    }
    [self setupRefresh];
    [self tableFooter];
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
    self.tableView=nil;
    self.dataTable=nil;
    self.HUD=nil;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"对象的视图已经加入到窗口时调用");
   _timer= [NSTimer scheduledTimerWithTimeInterval:0.1
           target:self selector:@selector(progressTracking) userInfo:self repeats:YES];
     

}

- (void)progressTracking
{
    [HUD showWhileExecuting:@selector(process) onTarget:self withObject:nil animated:YES];
    usleep(500);
}

-(void)process{
    
    while([Conf checkNetWork]==networkRight||[Conf checkNetWork]==networkError){
        [HUD hide:YES];
        if (_timer) {
            [_timer invalidate];
        }
    }
}
- (void) viewDidUnload{
    NSLog( @"TableView dealloc%@",self.description);
    [self.tableView removeHeader ];
    [self.tableView removeFooter];
    [HUD removeFromSuperview];
    [self.dataTable removeAllObjects];
    [super viewDidUnload];
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
    
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addLegendFooterWithRefreshingTarget:self
                                       refreshingAction:@selector(footerRereshing)];
    [self.tableView.footer setTitle:@""
                           forState:MJRefreshFooterStateNoMoreData];
    [self.tableView.header beginRefreshing];
    
}

-(void)tableFooter{
    errorInfo.text=@"";
    errorInfo.frame=BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                               NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT);
    [errorInfo setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:10]];
    [errorInfo setTextColor:[UIColor redColor]];
    [self.tableView.footer addSubview:errorInfo];
}

#pragma mark ----- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataTable.count;
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

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"默认为同返回一致的动作");
}

@end
