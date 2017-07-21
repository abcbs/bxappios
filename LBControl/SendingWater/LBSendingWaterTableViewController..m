//
//  TableViewController.m
//  民生小区
//
//  Created by L on 15/4/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import "LBSendingWaterTableViewController.h"

#import "BSUIFrameworkHeader.h"

#import "MSWaterSendingCell.h"

#import "KTFooterView.h"
#import "KTWaterDetailsViewController.h"
#import "LoginViewController.h"


@interface LBSendingWaterTableViewController ()
{
    NSInteger indexPath_row;
}

@end

@implementation LBSendingWaterTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/**
 *处理返回按钮
 */
- (IBAction)backClick:(id)sender{
     [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- tableView的代理方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //送水列表的TableViewCell
    MSWaterSendingCell *cell = [MSWaterSendingCell
                                cellWithTableView:tableView];
    WaterSending *model = self.dataTable[indexPath.row];
    //model自身定义
    cell.model = model;
    return cell;
}


- (void)loadMoreData:(long) warterId dataCount:(int)cellCount
{
    //显示对话框
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        //获取业务数据方法
        [WaterSending
         listWaterList:warterId dataCount:cellCount
         //屏蔽弹出信息
         errorUILabel:super.errorInfo
         //块的使用方式
         block:^(NSObject *response, NSError *error,ErrorMessage *errorMessage) {
             [self.dataTable addObjectsFromArray:(NSArray *)response];
             // 2.刷新表格UI 刷新表格
             [self.tableView reloadData];
         }
         ];
    } completionBlock:^{
        //[super.HUD hide:YES];
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
   
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexPath_row=indexPath.row;
    [self performSegueWithIdentifier:@"DetailProductDetail" sender:nil];
    //
}
*/
#pragma mark - Navigation
#pragma mark -
#pragma mark Stroyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailProductDetail"])
    {//浏览商品信息
        KTWaterDetailsViewController *shoppControl = (KTWaterDetailsViewController *)segue.destinationViewController;
      
        shoppControl.waterSending = self.dataTable[indexPath_row];
        [self checkLogin:shoppControl waterSending:self.dataTable[indexPath_row]];
    }
    
}
/**
 *根据是否登录来判断是否到购物车功能页
 */
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
        //如果登陆，则进入购物车
        [self.navigationController presentViewController:shoppControl animated:YES completion:nil   ];
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
