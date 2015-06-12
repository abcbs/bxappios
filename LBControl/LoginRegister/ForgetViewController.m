//
//  ForgetViewController.m
//  民生小区
//
//  Created by 闫青青 on 15/4/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ForgetViewController.h"
#import "LoginViewController.h"
@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"forget password-head.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 35, 25, 25)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
    //手机号输入框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 8;
    textField.layer.masksToBounds = YES;
    textField.placeholder = @"   手机号";
    [self.view addSubview:textField];
    //获取验证码button
    UIButton *huoQuButton = [[UIButton alloc]initWithFrame:CGRectMake(215, 100, 100, 50)];
    [huoQuButton setBackgroundImage:[UIImage imageNamed:@"forget password-3.png"] forState:UIControlStateNormal];
    huoQuButton.layer.cornerRadius = 8;
    [self.view addSubview:huoQuButton];
    //验证码
    UITextField *yanZhengCode = [[UITextField alloc]initWithFrame:CGRectMake(10, 155, 300, 50)];
    yanZhengCode.backgroundColor = [UIColor whiteColor];
    yanZhengCode.layer.cornerRadius = 8;
    yanZhengCode.layer.masksToBounds = YES;
    yanZhengCode.placeholder = @"  验证码";
    [self.view addSubview:yanZhengCode];
    //新密码
    UITextField *newCode = [[UITextField alloc]initWithFrame:CGRectMake(10, 210, 300, 50)];
    newCode.backgroundColor = [UIColor whiteColor];
    newCode.layer.cornerRadius = 8;
    newCode.layer.masksToBounds = YES;
    newCode.placeholder = @"  新密码";
    [self.view addSubview:newCode];
    //确认密码
    UITextField *configCode = [[UITextField alloc]initWithFrame:CGRectMake(10, 265, 300, 50)];
    configCode.backgroundColor = [UIColor whiteColor];
    configCode.layer.cornerRadius = 8;
    configCode.layer.masksToBounds = YES;
    configCode.placeholder = @"  确认密码";
    [self.view addSubview:configCode];
    //提交界面的提交按钮
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 320, 290, 45)];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"forget password-4.png"] forState:UIControlStateNormal];
    //    [submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}
//返回button点击事件
- (void)buttonClicked:(UIButton *)sender{
    //    ViewController *VC = [[ViewController alloc]init];
    [self dismissViewControllerAnimated:NO completion:^{
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
