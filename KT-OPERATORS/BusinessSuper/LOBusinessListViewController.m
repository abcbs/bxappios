//
//  LOBusinessListViewController.m
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOBusinessListViewController.h"
#import "LBModelsHeader.h"
#import "LOBusinsessMaintainViewController.h"
#import "LOBusinessDetailViewController.h"
#define rTableSectionCount 1

@interface LOBusinessListViewController ()
{
    //商家信息BusinessBaseDomain
    NSMutableArray *_bsList;
    //点击选中索引
    NSInteger _bsIndex;
}
@end

@implementation LOBusinessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //装载数据
    [self loadBusiness:nil];
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
    UITableViewCell *cell = [self obtainCellWith:@"LOBusinessListTableViewCell"];
    
    BusinessBaseDomail *bs=_bsList[indexPath.row];
   
    BusinessBase *bBase=bs.businessBase;
    UserBase *user=bs.artificial;
    cell.textLabel.text = bBase.name;
    NSString *detailInfo=@"";
    if (bBase.commerceLicense) {
        detailInfo=[detailInfo stringByAppendingFormat:@"营业执照:%@\t",
                    bBase.commerceLicense];
        
        
    }
    if (user.name) {
        detailInfo =[detailInfo stringByAppendingFormat:@"法人:%@",user.name];
        
    }
    cell.detailTextLabel.text = detailInfo;
    //p的图片，在服务端为资源标示
    cell.imageView.image = bBase.headerImage;
    return cell;
}

/**
 *选中某条数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessBaseDomail *bs;
    if (tableView == self.tableView)
    {
        bs = _bsList[indexPath.row];
        _bsIndex = indexPath.row;
        //[self performSegueWithIdentifier:@"BrowseBusiness" sender:nil];
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
    return @"删除商家?";
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    }
}
#pragma mark - Navigation
#pragma mark -
#pragma mark Stroyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BrowseBusiness"])
    {//浏览商品信息
        LOBusinessDetailViewController *evc = (LOBusinessDetailViewController *)segue.destinationViewController;
        evc.browseDelegate = self;
        BusinessBaseDomail *bs=(BusinessBaseDomail *)[_bsList objectAtIndex:_bsIndex];
        evc.business=bs;
    }
    if ([segue.identifier isEqualToString:@"AddBusiness"])
    {//商品维护
        LOBusinsessMaintainViewController *info = (LOBusinsessMaintainViewController *)segue.destinationViewController;
        info.editDelegate = self;
    }
}

#pragma mark 



#pragma mark --装载数据

/**
 *产品浏览
 */
- (void)sendEditedBusiness:(BusinessBaseDomail *)business{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    
    [_bsList addObject:business];
    [self.tableView reloadData];
    
    NSString *path = [self loadForBusinessList];
    [NSKeyedArchiver archiveRootObject:_bsList toFile:path];
}
/**
 *商家维护
 */
- (void)sendAddBusiness:(BusinessBaseDomail *) business{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    
    [_bsList addObject:business];
    [self.tableView reloadData];
    
    NSString *path = [self loadForBusinessList];
    [NSKeyedArchiver archiveRootObject:_bsList toFile:path];
    
}

/**
 *商家浏览
 */
- (void)sendBrowseBusiness:(BusinessBaseDomail *)business{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    
    [_bsList addObject:business];
    [self.tableView reloadData];
    
    NSString *path = [self loadForBusinessList];
    [NSKeyedArchiver archiveRootObject:_bsList toFile:path];
}

/**
 *更新数据
 */
- (void)refreshBusiness:(BusinessBaseDomail *)business{
    [_bsList removeObjectAtIndex:_bsIndex];
    [_bsList insertObject:business atIndex:_bsIndex];
 
    [self.tableView reloadData];
    
    NSString *path = [self loadForBusinessList];
    [NSKeyedArchiver archiveRootObject:_bsList toFile:path];
}

/**
 *装载初始化数据
 */
-(void) loadBusiness:(BusinessBaseDomail *)business{
    NSString *path = [self loadForBusinessList];
    _bsList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
}

#pragma mark --从本地装载数据
- (NSString *)loadForBusinessList
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"business.plist"];
    
    return path;
}


@end
