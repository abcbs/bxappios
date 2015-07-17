//
//  SecondViewController.m
//  KT-BUSINESS-SELLER
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSMainIndexViewController.h"
#import "BSIFTTHeader.h"
#import "BSUIFrameworkHeader.h"
@interface LSMainIndexViewController ()

@end

@implementation LSMainIndexViewController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
                             
        imageName:nil//章节显示图标
        headerViewClass:nil//章节显示视图
        cellIdentifier:@"BSUIImageTitleTableViewCell"//采用的TableViewCell
        cellClass:[BSUIImageTitleTableViewCell class]//TableViewCell实现
        storyboard:@"LSBLEIFTTUpHoldMain" bsContent:nil];
    
    bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"首页"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"LSBLEIFTTUpHoldMain"
                             colCapatibilty:5//每个章节的row数量
                             bsContent:nil];
    
    BSTableContentObject *bsnMagamer=[BSTableContentObject
                                initWithContentObject:@"商品"
                                methodName:nil
                                imageName:@"im_post.png"
                                vcClass:@"LSProductListTableViewController"
                                storybord:@"LSProductManagerMain"];
    

    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"首页"];
    
    
    
    bsnMagamer=[BSTableContentObject
                                      initWithContentObject:@"促销"
                                      methodName:nil
                                      imageName:@"im_activity.png"
                                      vcClass:@"BLEDevicesTableViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"首页"];
    
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"订单"
                methodName:nil
                imageName:@"ww.png"
                vcClass:@"BLEDevicesTableViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"首页"];
    
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"账务"
                methodName:nil
                imageName:@"im_paihao.png"
                vcClass:@"BLEDevicesTableViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"首页"];
    

    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"报表"
                methodName:nil
                imageName:@"im_kaika.png"
                vcClass:@"BLEDevicesTableViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"首页"];
    

    [super setValue:bsTable forKey:@"bSTableObjects"];
    
    //UIView *foot=[[UIView alloc]init];
    
    UIImageView *footView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_05.jpg"]];
    [footView sizeToFit];
    self.tableView.tableFooterView=footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginY(80);
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
}



@end
