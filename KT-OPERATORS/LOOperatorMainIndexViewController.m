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
                             initWithHeaderVcClassContent:@"业务范围类型管理"//章节显示标题
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
    
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"业务范围类型管理"];
    
    
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"新增"
                methodName:nil
                imageName:@"im_activity.png"
                vcClass:@"LOProductCatalogueMaintainViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"业务范围类型管理"];
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"选中"
                methodName:nil
                imageName:@"98bj@2x.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
    
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"业务范围类型管理"];
    
    //登陆用户（联系人）管理管理
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"检索"
                methodName:nil
                imageName:@"im_post.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
    bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer
                 sectionHeader:@"用户（联系人）管理管理"];
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"新增"
                methodName:nil
                imageName:@"im_activity.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
     bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer
                 sectionHeader:@"用户（联系人）管理管理"];
    
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"删除"
                methodName:nil
                imageName:@"98bj@2x.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
     bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer
                 sectionHeader:@"用户（联系人）管理管理"];
    
    //商户账户管理
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"检索"
                methodName:nil
                imageName:@"im_post.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
     bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商户账户管理"];
    
    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"对账"
                methodName:nil
                imageName:@"im_activity.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
     bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商户账户管理"];
    

    bsnMagamer=[BSTableContentObject
                initWithContentObject:@"开户"
                methodName:nil
                imageName:@"98bj@2x.png"
                vcClass:@"LOProductCatalogueDetailViewController"];
    
     bsnMagamer.storybordName=@"LOCatagoryManager";
    [bsTable addBSTableContent:bsnMagamer sectionHeader:@"商户账户管理"];
    
    //百度地图
    BSTableContentObject *bleDevices=[BSTableContentObject
                initWithContentObject:@"定位"
                methodName:nil
                imageName:@"im_reservation_jia.png"
                vcClass:@"BSBaiduViewController"];
    
    bleDevices.storybordName=@"BSMapMain";
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"百度地图"];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"上传"
                methodName:nil
                imageName:@"im_vote.png"
                vcClass:@"BSRadarUploadViewController"];
    bleDevices.storybordName=@"BSMapMain";
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"百度地图"];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"周边"
                methodName:nil
                imageName:@"ww.png"
                vcClass:@"BSRadarNearbyViewController"];
    
    bleDevices.storybordName=@"BSMapMain";
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"百度地图"];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"高德"
                methodName:nil
                imageName:@"im_search.png"
                vcClass:@"BSMAMapMainViewController"];
    
    bleDevices.storybordName=@"BSMAMapMain";
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"百度地图"];
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
