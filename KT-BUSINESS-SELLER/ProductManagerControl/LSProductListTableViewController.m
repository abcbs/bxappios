//
//  LSProductListTableViewController.m
//  KTAPP
//  商品管理，主界面实现商品增删、改、查的功能，
//  商品删除，商品的状态不变，其是上下架状态为下架
//  商品浏览: LSProductDetailTableViewController
//  商品修改: LSProductMaintainViewController

//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductListTableViewController.h"
//APP模型头文件
#import "LBModelsHeader.h"
//商家APP控制器
#import "LSControllerHeader.h"

#import "LSProductDetailTableViewController.h"

#define rTableSectionCount 1

@interface LSProductListTableViewController (){

    
    //商家商品信息BusinessProduct
    NSMutableArray *_bsList;
    //点击选中索引
    NSInteger _bsIndex;
    
    //检索信息
    NSMutableArray *_resultList;
    NSInteger _resultIndex;

}

@end

@implementation LSProductListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    //装载数据
    [self loadBusinessProduct:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload{
    //删除数据
    [_bsList removeAllObjects];
    [_resultList removeAllObjects];
    [super viewDidUnload];
}

- (void)dealloc{
    _bsList=nil;
    _resultList=nil;
    
}

#pragma mark TableView DataSource
/**
 *表的章节数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return rTableSectionCount;
}

/**
 *信息展现
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self obtainCellWith:@"LSProductListTableViewCell"];

    BusinessProduct *p;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {//查询
        p = _resultList[indexPath.row];
    }
    else
    {
        p = _bsList[indexPath.row];
    }
    
    cell.textLabel.text = p.name;
    NSString *detailInfo=@"";
    if (p.salePrice !=0) {
        detailInfo=[detailInfo stringByAppendingFormat:@"销售价:%.2f\t",p.salePrice];
        
        
    }
    if (p.preferPrice !=0) {
       detailInfo =[detailInfo stringByAppendingFormat:@"卡价格:%.2f",p.preferPrice];
        
    }
    cell.detailTextLabel.text = detailInfo;
    //p的图片，在服务端为资源标示
    cell.imageView.image = p.headerImage;
    return cell;
}

/**
 *选中某条数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessProduct *product;
    if (tableView == self.tableView)
    {
        product = _bsList[indexPath.row];
        _bsIndex = indexPath.row;
        [self performSegueWithIdentifier:@"BrowseCommodity" sender:nil];
    }else
    {//表示查询，另编码
        [self performSegueWithIdentifier:@"BrowseCommodity" sender:nil];
        product = _resultList[indexPath.row];
        
        _bsIndex = [_bsList indexOfObject:product];
        _resultIndex = indexPath.row;
    }
}

/*
 *数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return _resultList.count;
    }
    else
    {
        return _bsList.count;
    }
}

/**
 *显示章节标题
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.title;
}

#pragma mark -删除操作，删除之后，商户不可见，但监管者可见
/**
 *自定义划动时delete按钮内容
 */
- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除商品?";
}

/**
 *删除
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Remove the row from data model
        long row=indexPath.row;
        [_bsList removeObjectAtIndex:row];
        [_resultList removeObjectAtIndex:row ];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    }
}
#pragma mark - Navigation
#pragma mark -
#pragma mark Stroyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BrowseCommodity"])
    {//浏览商品信息
         LSProductDetailTableViewController *evc = (LSProductDetailTableViewController *)segue.destinationViewController;
        evc.browseDelegate = self;
        BusinessProduct *p=(BusinessProduct *)[_bsList objectAtIndex:_bsIndex];
        evc.product=p;
    }
    if ([segue.identifier isEqualToString:@"AddCommodity"])
    {//商品维护
        LSProductMaintainViewController *info = (LSProductMaintainViewController *)segue.destinationViewController;
        info.editDelegate = self;
        //[info setProduct:(BusinessProduct *)[_bsList objectAtIndex:_bsIndex]];
    }
}

#pragma mark -
#pragma mark --搜索实现的默认代理

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@", searchString];
    
    if (_resultList)
    {
        [_resultList removeAllObjects];
    }
    
    _resultList = [NSMutableArray arrayWithArray:[_bsList filteredArrayUsingPredicate:predicate]];
    
    return YES;
}

#pragma mark --装载数据

/**
 *产品维护
 */
- (void)addBusinessProduct:(BusinessProduct *) product{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    
    [_bsList addObject:product];
    [self.tableView reloadData];
    
    BusinessManager *bm=[BusinessManager businessManager];
    
    [bm insertBusinessProduct:product];

}

/**
 *产品浏览
 */
- (void)editedBusinessProduct:(BusinessProduct *)product{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    
    [_bsList addObject:product];
    [self.tableView reloadData];
    
    BusinessManager *bm=[BusinessManager businessManager];
    
    [bm updateBusinessProduct:product atIndex:_bsIndex];
}

/**
 *更新数据
 */
- (void)refreshBusinessProduct:(BusinessProduct *)product{
    [_bsList removeObjectAtIndex:_bsIndex];
    [_bsList insertObject:product atIndex:_bsIndex];
    [_resultList removeObjectAtIndex:_resultIndex];
    [_resultList insertObject:product atIndex:_resultIndex];
    
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self.tableView reloadData];
    
    BusinessManager *bm=[BusinessManager businessManager];
    
    [bm updateBusinessProduct:product atIndex:_bsIndex];

}

-(void) loadBusinessProduct:(BusinessProduct *)product{
    BusinessManager *bm=[BusinessManager businessManager];
    _bsList = [bm loadBusinessProduct:product];
    
}
@end
