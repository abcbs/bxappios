//
//  LFRecommendViewController.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LFRecommendViewController.h"
#import "BSUIFrameworkHeader.h"
#import "LBControllerHeader.h"

@implementation LFRecommendViewController
@dynamic tableView;

- (void)viewDidLoad {
    self.title=@"金融推荐";
    
    [super viewDidLoad];
    
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"金融推荐"//章节显示标题
                                                               imageName:@"tuijian_01.png"//章节显示图标
                                                         headerViewClass:nil//章节显示视图
                                                          cellIdentifier:@"BSUIImageTitleTableViewCell"//采用的TableViewCell
                                                               cellClass:[BSUIImageTitleTableViewCell class]//TableViewCell实现
                                                              storyboard:@"LFRecommend" bsContent:nil];
    
    //推荐客户
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"推荐客户"
                                                                     methodName:nil imageName:@"ww.png"
                                                                       colClass:[recommendguest class]];
    
    [bsTable addBSTableContent:recommend sectionHeader:@"金融推荐"];
    
    //推荐开卡
    BSTableContentObject *reCard=[BSTableContentObject
                                 initWithContentObject:@"推荐开卡"
                                 methodName:nil imageName:@"pp.png"
                                 colClass:[recommendCard class]];
    
    [bsTable addBSTableContent:reCard sectionHeader:@"金融推荐"];
    
    
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"推荐理财" methodName:nil imageName:@"322.png"
                                                                         colClass:nil];
    
    [bsTable addBSTableContent:appointment sectionHeader:@"金融推荐"];
    
       
    [super setValue:bsTable forKey:@"bSTableObjects"];
    
    
}

/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginY(160);
}

/**
 *覆盖父类实现，不显示章节标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

/**
 *覆盖，调整
 *每个section底部标题高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(4);
}@end
