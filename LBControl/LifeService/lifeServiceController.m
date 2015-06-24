//
//  lifeServiceController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "lifeServiceController.h"
#import "Conf.h"
@interface lifeServiceController ()

@end

@implementation lifeServiceController

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
    //button1
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-130, 80, 70, 70)];
    btn1.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [btn1 setImage:[UIImage imageNamed:@"98xc.png"] forState:UIControlStateNormal];
    //[btn1 addTarget:self action:@selector(bt1clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-130, 150, 100, 30)];
    label1.text = @"    洗车";
    [self.view addSubview:label1];
    //button2
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 80, 70, 70)];
    btn2.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [btn2 setImage:[UIImage imageNamed:@"98ss.png"] forState:UIControlStateNormal];
    //[btn2 addTarget:self action:@selector(bt2clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 150, 100, 30)];
    label2.text = @"    送水";
    [self.view addSubview:label2];
    //button2
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+70, 80, 70, 70)];
    btn3.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [btn3 setImage:[UIImage imageNamed:@"98cs.png"] forState:UIControlStateNormal];
    //[btn3 addTarget:self action:@selector(bt3clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+70, 150, 100, 30)];
    label3.text = @"    超市";
    [self.view addSubview:label3];
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
