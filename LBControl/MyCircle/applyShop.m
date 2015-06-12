//
//  applyShop.m
//  民生小区
//
//  Created by 闫青青 on 15/5/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "applyShop.h"
#import "Conf.h"
@interface applyShop ()

@end

@implementation applyShop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after  loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.1];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"yhkbd_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.057916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //添加TextField
    NSArray *array = @[@"   姓名",@"   证件号码",@"   手机号",@"   固定电话",@"   详细地址"];
    for(int i = 0;i <5;i++){
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.28125, SCREEN_HEIGHT*0.083)];
        label.text = array[i];
        label.font = [UIFont fontWithName:nil size:15];
        label.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
        label.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:label];
        //textField
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2925, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.7075-10, SCREEN_HEIGHT*0.083)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = i;
        [self.view addSubview:textField];
    }
    //提交按钮
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(120, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*4+70, 80, 40)];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"银行卡绑定-3.png"] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];

}
//返回button点击事件
- (void)buttonClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
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
