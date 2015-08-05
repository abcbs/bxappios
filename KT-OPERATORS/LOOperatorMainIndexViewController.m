//
//  LOOperatorMainIndexViewController.m
//  KTAPP
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOOperatorMainIndexViewController.h"

@interface LOOperatorMainIndexViewController ()

@end

@implementation LOOperatorMainIndexViewController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"系统运维"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"LOCatagoryManager"
                             colCapatibilty:5//每个章节的row数量
                             bsContent:nil];
    
    BSTableContentObject *bsnMagamer=[BSTableContentObject
            initWithContentObject:@"检索"
            methodName:nil
            imageName:@"im_post.png"
            vcClass:@"LOProductCatalogueListViewController"
            storybord:@"LOCatagoryManager"];
    
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"系统运维"];
    
    
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"新增"
                methodName:nil
                imageName:@"im_activity.png"
                vcClass:@"LOProductCatalogueMaintainViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"系统运维"];
    
    [super setValue:bsTable forKey:@"bSTableObjects"];
    
    
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

@end
