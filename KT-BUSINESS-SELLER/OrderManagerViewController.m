//
//  SecondViewController.m
//  KT-BUSINESS-SELLER
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "BSIFTTHeader.h"
#import "BSUIFrameworkHeader.h"
@interface OrderManagerViewController ()

@end

@implementation OrderManagerViewController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
                             
        imageName:nil//章节显示图标
        headerViewClass:nil//章节显示视图
        cellIdentifier:@"BSUIDefaultTableViewCell"//采用的TableViewCell
        cellClass:[BSUIDefaultTableViewCell class]//TableViewCell实现
        storyboard:@"BLEIFTTUpHoldMain" bsContent:nil];
    

    
    BSTableContentObject *bank=[BSTableContentObject
                                initWithContentObject:@"周边服务"
                                methodName:nil
                                imageName:@"98bj"//实现的控制器，在故事板中
                                vcClass:@"BLEDevicesTableViewController"];
    
    [bsTable addBSTableContent:bank sectionHeader:@"首页"];
    [super setValue:bsTable forKey:@"bSTableObjects"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
