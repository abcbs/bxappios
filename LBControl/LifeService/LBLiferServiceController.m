//
//  LBLiferServiceControllerViewController.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LBLiferServiceController.h"
#import "BSUIFrameworkHeader.h"
#import "LBControllerHeader.h"

@interface LBLiferServiceController ()
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
@property (nonatomic, copy) NSArray *imageNameArray;
@end

@implementation LBLiferServiceController
@dynamic tableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"便捷服务"//章节显示标题
                              imageName:@"xy"//章节显示图标
                              headerViewClass:nil//章节显示视图
                              cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                              cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                            
                              storyboard:@"KTWaterDetailsViewController"
                              colCapatibilty:4//每个章节的row数量
                              bsContent:nil];
    

    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"洗车"
                              methodName:nil imageName:@"98xc"
                               colClass:nil];
    recommend.noNeedLoginCheck=YES;
    
    [bsTable addBSTableContent:recommend sectionHeader:@"便捷服务"];
    
    
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"送水"
                                 methodName:nil imageName:@"98ss"
                                 vcClass:@"LBSendingWaterTableViewController"];
    commu.noNeedLoginCheck=YES;

    [bsTable addBSTableContent:commu sectionHeader:@"便捷服务"];
   
    
    BSTableContentObject *bank=[BSTableContentObject
                                initWithContentObject:@"保洁"
                                methodName:nil
                                imageName:@"98bj"
                                colClass:nil];
    bank.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:bank sectionHeader:@"便捷服务"];
    
    
    BSTableContentObject *tech=[BSTableContentObject initWithContentObject:@"家政" methodName:nil imageName:@"98jz" colClass:nil];
    tech.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:tech sectionHeader:@"便捷服务"];
    
    //超市
    tech=[BSTableContentObject initWithContentObject:@"超市" methodName:nil imageName:@"98cs" colClass:nil];
    tech.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:tech sectionHeader:@"便捷服务"];
    
    
    //预约服务
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"洗车" methodName:nil imageName:@"98xc" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:appointment sectionHeader:@"预约服务"];
    
    //配置错误
    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"送水" methodName:nil imageName:@"98ss" colClass:[LBSendingWaterTableViewController class]];
    lifeService.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:lifeService sectionHeader:@"预约服务"];
    
      
    [super setValue:bsTable forKey:@"bSTableObjects"];
    
    [self addImagePlay];
    self.tableView.tableHeaderView = self.imagePlayer;
}

/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginY(90);
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

/**
 *  添加头部图片轮播器
 */
- (void)addImagePlay{
    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++){
        NSString *imgName = [NSString stringWithFormat:@"img_0%d.jpg",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil];
}

@end
