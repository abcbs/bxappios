//
//  LOBuyerSuperMainIndexViewController.m
//  KTAPP
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOBuyerSuperMainIndexViewController.h"

@interface LOBuyerSuperMainIndexViewController ()

@end

@implementation LOBuyerSuperMainIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"商家监管"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"LOBuyerSuper"
                             colCapatibilty:5//每个章节的row数量
                             bsContent:nil];
    
    BSTableContentObject *bsnMagamer=[BSTableContentObject
                                      initWithContentObject:@"入驻"
                                      methodName:nil
                                      imageName:@"im_post.png"
                                      vcClass:@"LOBusinsessAddViewController"
                                      storybord:@"LOBuyerSuper"];
    
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商家监管"];
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"审核"
                methodName:nil
                imageName:@"ww.png"
                vcClass:@"LOBusinessAduitViewController"];
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商家监管"];
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"监管"
                methodName:nil
                imageName:@"im_activity.png"
                vcClass:@"LOBusinssSuperViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商家监管"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
