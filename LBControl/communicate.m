//
//  communicate.m
//  民生小区
//
//  Created by 闫青青 on 15/6/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "communicate.h"
#import "Conf.h"
#import "communicateCell.h"
#import "communicateController.h"
@interface communicate ()<UITableViewDataSource,UITableViewDelegate,communicateCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation communicate

- (void)viewDidLoad {
    [super viewDidLoad];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-270, 65)];
    NSString *imageName = [NSString stringWithFormat:@"jl_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0425, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.038125, self.view.bounds.size.width*0.040125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //完成按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.80125, SCREEN_HEIGHT*0.058916, SCREEN_WIDTH*0.140625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"fabu.png"] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"communicateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"communicateCell"];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    communicateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"communicateCell"];
    cell.delegate = self;

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)communicateZanClick{
    NSLog(@"点赞");
}
- (void)communicateCommentClick{
    NSLog(@"评论");
}


- (void)commitButtonClicked:(UIButton *)sender{
    communicateController *vc = [[communicateController alloc]init];
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
