//
//  SystemSet.m
//  民生小区
//
//  Created by 闫青青 on 15/5/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "SystemSet.h"
#import "SystemSetCell.h"
#import "Conf.h"
#import "userProtocol.h"
@interface SystemSet ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger i;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) NSArray *textArray;
/** 缓存文件大小 */
@property (nonatomic, copy) NSArray *files;

@end

@implementation SystemSet

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textArray = @[@"消息推送",@"清除缓存",@"用户协议",@"关于"];
    
    //滑不到头时改变这个属性
    self.automaticallyAdjustsScrollViewInsets = YES;
#pragma mark--tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATIONBAR_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"SystemSetCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SystemSetCell"];
    //设置每个section之间的间隙
    self.tableView.sectionHeaderHeight = 1;
    [self.view addSubview:self.tableView];
    
    //红色界面
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"h_01.png"];
    imageView.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 35, 25, 25)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //清除缓存按钮
    UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(265, 88, 40, 40)];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"ljt.png"] forState:UIControlStateNormal];
    //    clearButton.backgroundColor = [UIColor cyanColor];
    //    [clearButton setTitle:@"清除缓存" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:clearButton];
}
#pragma mark--UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemSetCell"];
    //Label赋值
    cell.systemLabel.text = self.textArray[indexPath.row];
    if(indexPath.row == 0){
#pragma mark--添加开关
        UISwitch * mySw = [[UISwitch alloc] initWithFrame:CGRectMake(260, 7, 50, 30)];
        mySw.on = NO;
        //        [mySw addTarget:self action:@selector(onOrOff:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:mySw];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.bounds.size.width/6.5;
}
//设置页头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//设置页脚高度，也就是cell之间的间隙
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
//点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
    }
    else if(indexPath.row == 2){
        userProtocol *userVC = [[userProtocol alloc]init];
        [self presentViewController:userVC animated:NO completion:nil];
    }
}
//返回button点击事件
- (void)buttonClicked2:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
//清理缓存
- (void)clear:(UIButton *)sender{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       _files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       //                       KT_AlertView_(@"该程序有[files count]个缓存文件");
                       NSLog(@"files :%ld",[_files count]);
                       for (NSString *p in _files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
}
-(void)clearCacheSuccess
{
    NSString *message = [NSString stringWithFormat:@"删除缓存文件:%ld个",[_files count]];
    KT_AlertView_(message);
    
    //    KT_AlertView_(@"清理成功");
    NSLog(@"清理成功");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
