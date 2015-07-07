//
//  LoginViewController.m
//  民生小区
//
//  Created by 闫青青 on 15/4/23.
//  Copyright (c) 2015年 闫青青. All rights reserved.
//

#import "LoginViewController.h"
//#import "ViewController.h"
#import "RegisterViewController.h"
#import "SetViewController.h"
#import "ForgetViewController.h"
#import "AFNHelp.h"
#import "RegistModel.h"
#import "Conf.h"
#import "LoginMessage.h"
#import "RegistUtil.h"
#import "AppDelegate.h"
@interface LoginViewController ()
@property (strong,nonatomic) UITextField *textField;
@property (strong,nonatomic) UITextField *passwText;
@property (strong,nonatomic) RegistModel *rs;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"login-head.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 35, 25, 25)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //注册按钮
    UIButton *registButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.78125, self.view.bounds.size.height*0.05091, self.view.bounds.size.width*0.140625, self.view.bounds.size.height*0.0430833)];
    [registButton setBackgroundImage:[UIImage imageNamed:@"login-4.png"] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(registButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
    
    //本地保存
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    //手机号输入框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.03125, self.view.bounds.size.height*0.1383, self.view.bounds.size.width*300/320, self.view.bounds.size.height*0.0841667)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.cornerRadius = 8;
    _textField.layer.masksToBounds = YES;
    _textField.placeholder = @"账号/手机号";
    _textField.textAlignment = NSTextAlignmentCenter;
    [userDefaults setObject:_textField.text forKey:@"username"];
    //密码输入框
    _passwText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03125, self.view.bounds.size.height*0.23292, self.view.bounds.size.width*300/320, self.view.bounds.size.height*0.0841667)];
    _passwText.backgroundColor = [UIColor whiteColor];
    _passwText.layer.cornerRadius = 8;
    _passwText.layer.masksToBounds = YES;
    _passwText.placeholder = @"密码";
    _passwText.secureTextEntry = YES;
    _passwText.textAlignment = NSTextAlignmentCenter;
    [userDefaults setObject:_passwText.text forKey:@"password"];
    [self.view addSubview:_textField];
    [self.view addSubview:_passwText];
    //登录界面的登录按钮
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03125, self.view.bounds.size.height*0.401667, self.view.bounds.size.width*300/320, self.view.bounds.size.height*0.09375)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login-1.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    //忘记密码button
    UIButton *forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.75, self.view.bounds.size.height*0.35, self.view.bounds.size.width*0.1875, self.view.bounds.size.height*0.02525)];
    [forgetButton setBackgroundImage:[UIImage imageNamed:@"login-0.png"] forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
}
//代理要实现的协议
- (void)LoginMessage:(NSString *)messages{
    self.loginMessage = messages;
    KT_AlertView_(self.loginMessage);
    if ([self.loginMessage isEqual:@"登录成功"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"aaa" object:self userInfo:nil];
        [self dismissViewControllerAnimated:NO completion: nil];
    }
}
//返回button点击事件
- (void)buttonClicked1:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
//登录button点击事件
- (void)loginButtonClicked:(UIButton *)sender{
    //校验  LoginMessage
    if([_textField.text isEqualToString:@""]){
        KT_AlertView_(@"用户名不能为空!");
        return;
    }
    else if(![RegistUtil checkPassword:_passwText.text]){
        KT_AlertView_(@"用户密码必须是6-12位数字和字母组合!");
        return;
    }
    _rs = [[RegistModel alloc]init];
    _rs.userName = self.textField.text;
    _rs.phoneNum = self.textField.text;
    _rs.passWord = self.passwText.text;
    _rs.delegate1 = self;
    
    [_rs loginSuccess];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"aaa" object:self userInfo:nil];
    //取出errorCode
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _errorLogin = [userDefaults objectForKey:@"responseHeader"];
    if (![[_errorLogin objectForKey:@"errorCode"] isEqualToString:Success]) {
        
    }
    else if([[_errorLogin objectForKey:@"errorCode"] isEqualToString:Success]){
    }
}
//注册button点击事件
- (void)registButtonClicked:(UIButton *)sender{
    //    ViewController *VC = [[ViewController alloc]init];
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self presentViewController:registVC animated:NO completion:nil];
}
//忘记密码button点击事件
- (void)forgetButtonClicked:(UIButton *)sender{
    ForgetViewController *forgetVC = [[ForgetViewController alloc]init];
    [self presentViewController:forgetVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
