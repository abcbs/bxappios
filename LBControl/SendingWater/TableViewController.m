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
#import "KTWaterDetailsViewController.h"
#import "LoginViewController.h"

#import "BSTableViewRefresh.h"

#import "BSUIComponentView.h"
#import "AppDelegate.h"

@interface TableViewController ()


@end

@implementation TableViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Conf navigationControllerHeader:self.navigationController ];
    //[self loadMoreData:[self firstDataId] dataCount:1];

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


- (IBAction)backClick:(id)sender{
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
        //获取业务数据方法
        [WaterSending
         listWaterList:warterId dataCount:cellCount
         //屏蔽弹出信息
         errorUILabel:[[UILabel alloc] init]
         //块的使用方式
         block:^(NSObject *response, NSError *error,ErrorMessage *errorMessage) {
             [self.dataTable addObjectsFromArray:(NSArray *)response];
             // 2.刷新表格UI 刷新表格
             [self.tableView reloadData];
            }
         ];
    } completionBlock:^{
    }];
    
}

// 点击某一行，进入产品详细页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    KTWaterDetailsViewController *shoppControl = [storyboard instantiateViewControllerWithIdentifier:@"KTWaterDetailsViewController"];
    shoppControl.waterSending = self.dataTable[indexPath.row];
    
    [self checkLogin:shoppControl waterSending:self.dataTable[indexPath.row]];
    
    //[self.navigationController pushViewController:shoppControl animated:YES];
   
    [self.navigationController presentViewController:shoppControl animated:YES completion:nil   ];
}

-(void)checkLogin:(KTWaterDetailsViewController *)shoppControl
     waterSending:(WaterSending *)waterSending
{
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sessionID = [userDefaults objectForKey:@"sessionId"];
    if (sessionID.length == 0) {
        LoginViewController  *nv = [[LoginViewController  alloc]init];
        
        [self presentViewController:nv animated:YES completion:nil];
    }else{
    ShoppingCart *shoppingCart =[[ShoppingCart alloc] init];
    shoppingCart.sessionId=sessionID;
    shoppingCart.currentCount=[[NSNumber alloc] initWithLong:0];
    shoppingCart.businessProductId=[[NSNumber alloc]
                                    initWithLong:waterSending.id];
    [self getCard:shoppingCart];
    shoppControl.shoppingCart=shoppingCart;
    }
}

-(void) getCard:(ShoppingCart *)shoppingCart

{
    [ShoppingCart addCart:shoppingCart
               blockArray:nil
     ];
    
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
