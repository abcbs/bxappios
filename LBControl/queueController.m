//
//  queueController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "queueController.h"
#import "Conf.h"
#import "enquireController.h"
@interface queueController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation queueController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_ADD_STATUS_HEIGHT-5, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text = @"XX银行XX支行";
    cell.detailTextLabel.text = @"北京西直门外大街18号";
    UIImageView *iconBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-25, 20, 15, 15)];
    NSString *imageName = @"a13.png";
    iconBackImage.image = [UIImage imageNamed:imageName];
    [cell.contentView addSubview:iconBackImage];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100, 10, 90, 30)];
    label.text = @"777米";
    [cell.contentView addSubview:label];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    enquireController *vc = [[enquireController alloc]init];
    
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
