//
//  TableViewController.m
//  民生小区
//
//  Created by L on 15/4/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "TableViewController.h"
#import "MSWaterSendingCell.h"

#import "KTFooterView.h"
#import "EHNetwork.h"
#import "KTWaterDetailsViewController.h"


#import "BSTableViewRefresh.h"
#import "ErrorMessage.h"


//#define Url  @"http://192.168.1.103:8090/water/waterinformations/1/0/10"

@interface TableViewController ()

@property (nonatomic, strong) EHNetwork *mNetwork;


@end

@implementation TableViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setupRefresh];
    // 初始化网络请求
    self.mNetwork = [[EHNetwork alloc] init];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{

    //1.网络加载数据
    [self loadMoreData:[self firstDataId] dataCount:[super pageCount]];
    // 2.刷新表格UI
    [self.tableView reloadData];
    // 3. 结束刷新状态
    [self.tableView.header endRefreshing];
    //
    
}

- (void)footerRereshing
{
   
    //1.网络加载数据
    [self loadMoreData:self.lastDataId dataCount:[super pageCount]];
    
    // 2.刷新表格UI 刷新表格
    [self.tableView reloadData];
    
     // 3. 结束刷新状态
     [self.tableView.footer endRefreshing];
    
}


- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{  //加载的数据放在大数组里面,tableView有多少数据是靠这数组来算
    NSLog(@"%ld", (unsigned long)self.dataTable.count);
    return self.dataTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MSWaterSendingCell *cell = [MSWaterSendingCell cellWithTableView:tableView];
    WaterSending *model = self.dataTable[indexPath.row];
    cell.model = model;
    return cell;
}



- (void)loadMoreData:(long) warterId dataCount:(int)cellCount
{
    //显示对话框
    [super.HUD showAnimated:YES whileExecutingBlock:^{
        
        [WaterSending
         listWaterList:warterId dataCount:cellCount
         blockArray:^(NSMutableArray *warters, NSError *error,ErrorMessage *errorMessage) {
             if (!error) {
                 [self.dataTable addObjectsFromArray:warters];
             }else{
                 //服务端没有启动或者系统异常
                 UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                    message:error.description delegate:nil
                    cancelButtonTitle:@"确定"
                    otherButtonTitles:nil];
                 
                 [alert show];
               
             }
             if (errorMessage) {
                 NSLog(@"已经是最后一条数据");
                 [self.tableView.footer noticeNoMoreData];
             }else{
                 
             }
             [self.tableView reloadData];
         }
         
         ];
    } completionBlock:^{
        //操作执行完后取消对话框
        //[_HUD removeFromSuperview];
       // _HUD = nil;
    }];
    
}

// 点击某一行，进入产品详细页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    KTWaterDetailsViewController *login2 = [storyboard instantiateInitialViewController];
    login2.waterSending = self.dataTable[indexPath.row];
    [self.navigationController pushViewController:login2 animated:YES];
    
    
}

-(long )firstDataId{
   WaterSending *ws=[self.dataTable firstObject];
    return ws.id;
}

-(long )lastDataId{
    WaterSending *ws=[self.dataTable lastObject];
    return ws.id;
}



@end
