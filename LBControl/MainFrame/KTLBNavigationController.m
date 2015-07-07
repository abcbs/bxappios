//
//  KTLBNavigationController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLBNavigationController.h"
#import "LBControllerHeader.h"
#import "BSUIFrameworkHeader.h"
#import "KTLifeIndexCell.h"
@interface KTLBNavigationController()<BSImagePlayerDelegate>
    @property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
    @property (nonatomic, copy) NSArray *imageNameArray;
@end

@implementation KTLBNavigationController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
                                                               imageName:@"tuhongse"//章节显示图标
                                                         headerViewClass:nil//章节显示视图
                                                          cellIdentifier:@"KTLifeIndexCell"//采用的TableViewCell
                                                               cellClass:[KTLifeIndexCell class]//TableViewCell实现
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
    
    
    [super setValue:bsTable forKey:@"bSTableObjects"];
    
    [self addImagePlay];
    self.tableView.tableHeaderView = self.imagePlayer;
    //[self.view  addSubview: self.imagePlayer];
}

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

//覆盖，为了显示最后一条数据
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return BSMarginY(120);
}
@end
