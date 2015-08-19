//
//  LOLoginUserListViewController.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserListViewController.h"
#import "LOLoginUserDetailViewController.h"
#import "LOLoginUserMaintainViewController.h"
#import "LBModelsHeader.h"
#import "LOLoginAppViewController.h"

@interface LOLoginUserListViewController ()
{
    //信息LoginUser
    NSMutableArray *_bsList;
    //点击选中索引
    NSInteger _bsIndex;
    LOLoginUserDetailViewController *evc;
}
@end

@implementation LOLoginUserListViewController

- (void)viewDidLoad {
    self.inform=@"10";
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=[UIColor blackColor];
    
    [self loadLoginUser:nil];
 
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.inform=@"8";
    BSLog(@"LOLoginUserListViewController viewDidAppear 消息通知,%@",self.inform);
    [super viewDidAppear:YES];
    
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
    return 1;
}

/**
 *信息展现
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [self obtainCellWith:@"LOLoginUserListViewCell"];
    
    LoginUser *lu=_bsList[indexPath.row];
    cell.textLabel.text = lu.realName;
    
    cell.detailTextLabel.text = lu.userName;
    //p的图片，在服务端为资源标示
    if (lu.headerImage) {
        cell.imageView.image = lu.headerImage;
    }
    

    return cell;
}

/**
 *选中某条数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    LoginUser *lu;
    if (tableView == self.tableView)
    {
        lu = _bsList[indexPath.row];
        _bsIndex = indexPath.row;
        evc.loginUser=lu;
      
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
    return @"删除此用户?";
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
        [self removeLoginUser:[_bsList objectAtIndex:row]];
        [_bsList removeObjectAtIndex:row];
        
        [tableView reloadData];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BrowseLoginUser"])
    {//浏览信息
       evc =
        (LOLoginUserDetailViewController *)segue.destinationViewController;
        evc.browseDelegate = self;
        LoginUser *lu=(LoginUser *)[_bsList objectAtIndex:_bsIndex];
        evc.loginUser=lu;
        
    }
    if ([segue.identifier isEqualToString:@"AddLoginUser"])
    {//维护信息
        LOLoginUserMaintainViewController *info = (LOLoginUserMaintainViewController *)segue.destinationViewController;
        info.editDelegate = self;
    }
}



/**
 *维护
 */
- (void)editedLoginUser:(LoginUser *) user{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    if (_bsList.count>0) {
        [_bsList removeObjectAtIndex:_bsIndex];
        [_bsList insertObject:user atIndex:_bsIndex];
    }
    [self.tableView reloadData];
    UserManager *um=[UserManager userManager];
    
    [um updateLoginUser:user atIndex:_bsIndex];
}

- (void)editedLoginUser:(LoginUser *) user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    if (_bsList.count>0) {
        [_bsList removeObjectAtIndex:_bsIndex];
        [_bsList insertObject:user atIndex:_bsIndex];
    }
    [self.tableView reloadData];
    UserManager *um=[UserManager userManager];
    
    [um updateLoginUser:user blockArray:block];
}

/**
 *装载初始化数据
 */
-(void) loadLoginUser:(LoginUser *) user{
    UserManager *um=[UserManager userManager];

    _bsList = [um loadLoginUser:nil];

}

/**
 *装载初始化数据
 */
-(void) removeLoginUser:(LoginUser *) user{
    UserManager *um=[UserManager userManager];
    
    [um removeLoginUser:user];
    [um removeLoginUserWithIndex:_bsIndex];
}

/**
 *新增
 */
- (void)addLoginUser:(LoginUser *) user{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    [_bsList addObject:user];
    [self.tableView reloadData];
    
    UserManager *um=[UserManager userManager];
    
    //[um insertLoginUser:user];
    [um insertLoginUser:user
             blockArray:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                 
                 BSLog(@"UserManager insertLoginUser");
             }
     
     ];


}

/**
 *新增
 */
- (void)addLoginUser:(LoginUser *) user
          blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block{
    if (!_bsList)
    {
        _bsList = [NSMutableArray array];
    }
    [_bsList addObject:user];
    [self.tableView reloadData];
    
    UserManager *um=[UserManager userManager];
    //[um insertLoginUser:user];
    [um insertLoginUser:user
             blockArray:block
     ];
    
    
}

@end
