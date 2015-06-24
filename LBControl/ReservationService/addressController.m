//
//  addressController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "addressController.h"
#import "Conf.h"
#import "adsCell.h"
#import "cleaning.h"
@interface addressController ()<UITableViewDataSource,UITableViewDelegate,adsDelegate>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation addressController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark--tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"adsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"adsCell"];
    //设置每个section之间的间隙
    self.tableView.sectionHeaderHeight = 1;
    [self.view addSubview:self.tableView];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"yyfw9_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    adsCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"adsCell"];
    cell1.delegate1 = self;
    
    return cell1;
}
- (void)adsButtonClicked{
   NSLog(@"选中");
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    cleaning *vc = [[cleaning alloc] init];
    
    [self presentViewController:vc animated:NO completion:nil];
    
}
- (void)buttonClickeds:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
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
