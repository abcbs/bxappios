//
//  LBHandySearchNavViewController.m
//  KTAPP
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSHandySearchNavViewController.h"

@interface LSHandySearchNavViewController()

@end

@implementation LSHandySearchNavViewController
@dynamic tableView;


- (void)viewDidLoad {
    //self.title=@"周边查找";
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:self.title//章节显示标题
       imageName:nil//章节显示图标
       headerViewClass:nil//章节显示视图
       cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
       cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
       storyboard:@"LSBLEIFTTUpHoldMain"
       colCapatibilty:3//每个章节的row数量
      bsContent:nil];
    
    
    
    BSTableContentObject *bleDevices=[BSTableContentObject
                                      initWithContentObject:@"周边"
                                      methodName:nil
                                      imageName:@"im_reservation_jia.png"
                                      vcClass:@"BLEDevicesTableViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                 initWithContentObject:@"查找"
                 methodName:nil
                 imageName:@"im_vote.png"
                 vcClass:@"BTLECentralViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"广播"
                methodName:nil
                imageName:@"ww.png"
                vcClass:@"BTLEPeripheralViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
    //百度地图
    bleDevices=[BSTableContentObject
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
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginY(160);
}
*/
/**
 *覆盖父类实现，不显示章节标题
 */
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
*/
/**
 *覆盖，调整
 *每个section底部标题高度
 */
/*
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(4);
}
*/
@end
