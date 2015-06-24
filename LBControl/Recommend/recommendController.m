//
//  recommendController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "recommendController.h"
#import "recommendguest.h"
#import "recommendCard.h"
#import "Conf.h"
@interface recommendController ()

@end

@implementation recommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"tuijian_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //button1
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100+0*100, 100, 100)];
    btn1.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [btn1 setImage:[UIImage imageNamed:@"ww.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(bt1clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-35, 200+0*20, 100, 30)];
    label1.text = @"推荐客户";
    [self.view addSubview:label1];
    //button2
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100+1*150, 100, 100)];
    [btn2 setImage:[UIImage imageNamed:@"pp.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(bt2clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-35, 200+1*150, 100, 30)];
    label2.text = @"推荐开卡";
    [self.view addSubview:label2];
    //button3
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100+2*150, 100, 100)];
    btn3.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [btn3 setImage:[UIImage imageNamed:@"322.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-35, 200+2*150, 100, 30)];
    label3.text = @"推荐理财";
    [self.view addSubview:label3];
    
}
- (void)bt1clicked:(UIButton *)sender{
    recommendguest *vc1 = [[recommendguest alloc]init];
    [self presentViewController:vc1 animated:NO completion:nil];
}
- (void)bt2clicked:(UIButton *)sender{
    recommendCard *vc2 = [[recommendCard alloc]init];
    [self presentViewController:vc2 animated:NO completion:nil];
}
- (void)buttonClickeds:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
