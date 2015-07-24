//
//  BSUITableViewCommonController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"

@implementation BSUITableViewCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
    navigationProcess:self
                                                     title:self.title];
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];
        [BSUIComponentView navigationHeader:self.navigationController];
        
    }else{

        //没有导航栏，使用Button完成
        [BSUIComponentView initTableNarHeaderWithDefault:self tableView:self.tableView  title: self.title];
        
    }
  
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];
    
    if (self.tableView==nil) {
        NSLog(@" BSUITableViewCommonController tableView is null");
    }else{
        self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.tableView.frame=BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT);
        
        self.tableView.dataSource =self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    BSLog(@"BSUICommonController viewDidAppear,%@",self.description);

}



#pragma mark --表格样式
/**
 *每个section底部标题高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(30);
}
/**
 *选中之前执行,判断选中的行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark --表格处理获取TableViewCell默认
/**
 *私有方法获取Cell的标示
 */
- (UITableViewCell *)obtainCellWith:(NSString *)identifer{
    UITableViewCell *cell=nil;
    cell=[self.tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    return cell;
}
#pragma mark --默认处理方法
#pragma mark --默认返回方法，仅仅在人工提供的状态栏中使用
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --默认统一处理方法，使用表格查询方式
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
}

#pragma mark --轮播事件响应 有轮播图，需要点击轮播图处理信息
- (void)touchAction:(UIGestureRecognizer *)gester{
    BSLog(@"子类应当继承此方法实现完成轮播功能功能");
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];
}

#pragma mark --功能装配控制器的跳转方法
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}


@end
