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
       cellIdentifier:@"BSUIImageTitleTableViewCell"//采用的TableViewCell
       cellClass:[BSUIImageTitleTableViewCell class]//TableViewCell实现
       storyboard:@"BLEIFTTUpHoldMain" bsContent:nil];
    
    
    
    BSTableContentObject *bleDevices=[BSTableContentObject
                                      initWithContentObject:@"周边服务"
                                      methodName:nil
                                      imageName:@"im_reservation_jia.png"
                                      vcClass:@"BLEDevicesTableViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                 initWithContentObject:@"懒人查找"
                 methodName:nil
                 imageName:@"im_vote.png"
                 vcClass:@"BTLECentralViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"周边广播"
                methodName:nil
                imageName:@"ww.png"
                vcClass:@"BTLEPeripheralViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:self.title];
    
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
    return BSMarginY(160);
}

/**
 *覆盖父类实现，不显示章节标题
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.title;
}

/**
 *覆盖，调整
 *每个section底部标题高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(4);
}

@end
