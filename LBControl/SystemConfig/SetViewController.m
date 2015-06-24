//
//  SetViewController.m
//  主界面，我的圈子
//
//  Created by 闫青青 on 15/4/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "SetViewController.h"
#import "SetCell.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Conf.h"
#import "SystemSet.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import "WXApi.h"
//#import "WeiboApi.h"
//#import "WeiboSDK.h"
#import "myWallet.h"
#import "applyShop.h"
#import "Demo1ViewController.h"
#import "AppDelegate.h"


@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) NSArray *textArray;
@property (nonatomic, copy) NSArray *imageNameArray;

@end

@implementation SetViewController
@synthesize tableView = _tableView;
@synthesize textArray = _textArray;
@synthesize imageNameArray = _imageNameArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textArray = @[@"购物车",@"全部订单",@"我的钱包",@"退款单",@"我的消息",@"我要开店",@"一键分享",@"系统设置"];
    self.imageNameArray = @[@"b-1.png",@"h-1.png",@"f-1.png",@"g-1.png",@"e-1.png",@"d-1.png",@"c-1.png",@"a-1.png"];
    //滑不到头时改变这个属性
    self.automaticallyAdjustsScrollViewInsets = YES;
#pragma mark--tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATIONBAR_HEIGHT+85 , SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"SetCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SetCell"];
    //设置每个section之间的间隙
    self.tableView.sectionHeaderHeight = 1;
    [self.view addSubview:self.tableView];
    
    //红色界面
  
    UIImageView *imageView=[Conf navigationHeaderWithImage:@"生活圈.jpg"];
    [self.view addSubview:imageView];
    
    //头像设置
    UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-45, 70, 90, 90)];
    [iconButton setBackgroundImage:[UIImage imageNamed:@"LoginPicture.png"] forState:UIControlStateNormal];
    iconButton.layer.cornerRadius = 8;
    iconButton.layer.masksToBounds = YES;
    
    //头像后面的白色背景
    UIImageView *iconBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 95)];
    NSString *iconBackImageName = [NSString stringWithFormat:@"640-90.png"];
    iconBackImage.image = [UIImage imageNamed:iconBackImageName];
    [self.view addSubview:iconBackImage];
    [self.view addSubview:iconButton];
    
    //登录button
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(23, 120, 70, 30)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //注册button
    UIButton *registButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-90, 120, 70, 30)];
    [registButton setBackgroundImage:[UIImage imageNamed:@"regist.png"] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [self.view addSubview:registButton];
    //分享button
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 43)];
    //    [shareButton setBackgroundImage:[UIImage imageNamed:@"c-1.png"] forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:shareButton];
}
//主界面注册button点击事件
- (void)click:(UIButton *)sender{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self presentViewController:registVC animated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }
    else if(section == 1){
        return 2;
    }
    else if(section == 2){
        return 1;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetCell *setCell = [tableView dequeueReusableCellWithIdentifier:@"SetCell"];
    if(indexPath.section == 0){
        setCell.iconImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row + 0]];
        setCell.nameLabel.text = self.textArray[indexPath.row + 0];
    }
//    else if(indexPath.section == 0&&indexPath.row == 1){
//        MyOrder *orderCell = [tableView dequeueReusableCellWithIdentifier:@"MyOrder"];
//        if(orderCell == nil){
//            NSArray *orderArray = [[NSBundle mainBundle]loadNibNamed:@"MyOrder" owner:nil options:nil];
//            orderCell = orderArray[0];
//        }
//        return orderCell;
//    }
    else if(indexPath.section == 1){
        setCell.iconImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row + 2]];
        setCell.nameLabel.text = self.textArray[indexPath.row + 2];
        if(indexPath.row == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 90, 30)];
            label.text = @"银行卡绑定";
            label.textColor = [UIColor lightGrayColor];
            [setCell.contentView addSubview:label];
            
        }
    }
    else if(indexPath.section == 2){
        setCell.iconImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row + 4]];
        setCell.nameLabel.text = self.textArray[indexPath.row + 4];
    }else if (indexPath.section == 3){
        setCell.iconImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row + 5]];
        setCell.nameLabel.text = self.textArray[indexPath.row + 5];
    }
    
    return setCell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
// 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.bounds.size.width/7.5;
}
//设置页头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//设置页脚高度，也就是cell之间的间隙
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&&indexPath.row == 1){
        Demo1ViewController *demo = [[Demo1ViewController alloc]init];
        [self presentViewController:demo animated:NO completion:nil];
//        MyOrder *order = [[MyOrder alloc]init];
//        [self presentViewController:order animated:NO completion:nil];
    }
     else if(indexPath.section == 3&&indexPath.row == 2){
        SystemSet *setVC = [[SystemSet alloc]init];
        [self presentViewController:setVC animated:NO completion:nil];
    }else if (indexPath.section == 1&&indexPath.row == 0){
        myWallet *wallatVC = [[myWallet alloc]init];
        [self presentViewController:wallatVC animated:NO completion:nil];
    }else if (indexPath.section == 3&&indexPath.row == 0){
        applyShop *shop = [[applyShop alloc]init];
        [self presentViewController:shop animated:NO completion:nil];
    }
}
//登录button点击事件
- (void)buttonClicked:(UIButton *)sender{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:NO completion:nil];
}
//分享button的点击事件
- (void)share:(UIButton *)sender{
    //shareSDK分享
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    //    NSString *imagePath =@"http://www.baidu.com";
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
