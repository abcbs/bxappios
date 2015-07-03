//
//  expressController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "expressController.h"
#import "Conf.h"
@interface expressController ()
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextField *contentText;
@end

@implementation expressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.05];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"fbxq_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //完成按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.80125, SCREEN_HEIGHT*0.058916, SCREEN_WIDTH*0.140625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"fabu.png"] forState:UIControlStateNormal];
//    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    _titleText = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.1383, self.view.bounds.size.width, self.view.bounds.size.height*0.0841667)];
    _titleText.backgroundColor = [UIColor whiteColor];
    _titleText.placeholder = @"标题";
    _titleText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_titleText];
    
    _contentText = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.1383*1.7, self.view.bounds.size.width, self.view.bounds.size.height*0.0841667*3)];
    _contentText.backgroundColor = [UIColor whiteColor];
    _contentText.placeholder = @"需求内容...";
    _contentText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_contentText];
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
