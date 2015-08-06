//
//  LOProductCatalogueListViewController.m
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOProductCatalogueListViewController.h"
#import "LBModelsHeader.h"
#import "LOProductCatalogueDetailViewController.h"
#import "LOProductCatalogueMaintainViewController.h"


#define rTableSectionCount 1

@interface LOProductCatalogueListViewController ()
{
    //类型信息ProductCatalogue
    NSMutableArray *_bsList;
    //点击选中索引
    NSInteger _bsIndex;
    
    LOProductCatalogueDetailViewController *evc;
}

@end


@implementation LOProductCatalogueListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //装载数据
    [self loadProductCatalogue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload{
    //删除数据
    [_bsList removeAllObjects];
    [super viewDidUnload];
}

- (void)dealloc{
    _bsList=nil;
    
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
    UITableViewCell *cell = [self obtainCellWith:@"LOProductCatalogueListTableViewCell"];
    
    ProductCatalogue *pc=_bsList[indexPath.row];
    cell.textLabel.text = pc.code;
   
    cell.detailTextLabel.text = pc.comment;
    return cell;
}

/**
 *选中某条数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCatalogue *bs;
    if (tableView == self.tableView)
    {
        bs = _bsList[indexPath.row];
        _bsIndex = indexPath.row;
         evc.productCatalogue=bs;
        
    }
}

/*
 *数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _bsList.count;
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
    return @"删除业务范围?";
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
        //_bsIndex=row;
        [self removeProductCatalogue:[_bsList objectAtIndex:row]];
        [_bsList removeObjectAtIndex:row];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BrowseCatagory"])
    {//浏览信息
        evc = (LOProductCatalogueDetailViewController *)segue.destinationViewController;
        evc.browseDelegate = self;
        ProductCatalogue *pc=(ProductCatalogue *)[_bsList objectAtIndex:_bsIndex];
        evc.productCatalogue=pc;
    
    }
    if ([segue.identifier isEqualToString:@"AddCatalogue"])
    {//维护信息
        LOProductCatalogueMaintainViewController *info = (LOProductCatalogueMaintainViewController *)segue.destinationViewController;
        info.editDelegate = self;
    }
}


-(void) removeProductCatalogue:(ProductCatalogue *)catagory{
    ProductManager *bm=[ProductManager productManager];
    
    [bm removeProductCatalogue:catagory];
    [bm removeProductCatalogueWithIndex:_bsIndex];
}
/**
 *维护商家信息
 */
- (void)editedProductCatalogue:(ProductCatalogue *)catagory{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    if (_bsList.count>0) {
        [_bsList removeObjectAtIndex:_bsIndex];
        [_bsList insertObject:catagory atIndex:_bsIndex];
    }
    [self.tableView reloadData];
    ProductManager *bm=[ProductManager productManager];
    
    [bm updateProductCatalogue:catagory atIndex:_bsIndex];
    
}

/**
 *商家新增
 */
- (void)addProductCatalogue:(ProductCatalogue *) catagory{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    [_bsList addObject:catagory];
    [self.tableView reloadData];
    ProductManager *bm=[ProductManager productManager];
    
    [bm insertProductCatalogue:catagory];
    
}



/**
 *装载初始化数据
 */
-(void) loadProductCatalogue:(ProductCatalogue *)catagory{
    ProductManager *pm=[ProductManager productManager];
    _bsList = [pm loadProductCatalogue:nil];
    
}


@end
