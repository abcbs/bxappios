//
//  BankManagerViewController.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BankManagerViewController.h"
#import "LBControllerHeader.h"
@interface BankManagerViewController ()

@end

@implementation BankManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
                                                               imageName:@"tuhongse"//章节显示图标
                                                         headerViewClass:nil//章节显示视图
                                                          cellIdentifier:@"BSUISingleImageTableViewCell"//采用的TableViewCell
                                                               cellClass:[BSUISingleImageTableViewCell class]//TableViewCell实现
                                                              storyboard:@"LFRecommend" bsContent:nil];
    
    //推荐
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"推荐"
                                                                     methodName:nil imageName:@"tuhongse.png"
                                                                       colClass:[LFRecommendViewController class]];
    
    [bsTable addBSTableContent:recommend sectionHeader:@"首页"];
    
    //交流
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"交流"
                                 methodName:nil imageName:@"tukuaihuang.png"
                                 colClass:[communicate class]];
    
    [bsTable addBSTableContent:commu sectionHeader:@"首页"];
    
    
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"预约服务" methodName:nil imageName:@"tulvse.png"
                                                                         colClass:[appointmentController class]];
    
    [bsTable addBSTableContent:appointment sectionHeader:@"首页"];
    
    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"生活服务" methodName:nil imageName:@"tukuailvse.png"
                                                                         colClass:[lifeServiceController class]];
    
    [bsTable addBSTableContent:lifeService sectionHeader:@"首页"];
    
    
    BSTableContentObject *bank=[BSTableContentObject
                                initWithContentObject:@"银行业务预约"
                                methodName:nil
                                imageName:@"tukuail.png"
                                colClass:[bankController class]];
    
    [bsTable addBSTableContent:bank sectionHeader:@"首页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
