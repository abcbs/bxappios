//
//  myWallet.m
//  民生小区
//
//  Created by 闫青青 on 15/5/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "myWallet.h"
#import "Conf.h"
#import "cardBinding.h"
@interface myWallet ()

@end

@implementation myWallet

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.005];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"zffs_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.057916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //下一步按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.78125, SCREEN_HEIGHT*0.062916, SCREEN_WIDTH*0.160625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"银行卡绑定-6.png"] forState:UIControlStateNormal];
    
    //    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    //银行卡
    UIButton *cardButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 60+0*50+20, SCREEN_WIDTH-10, 50)];
    [cardButton setTitle:@"银行卡" forState:UIControlStateNormal];
    [cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cardButton.layer setBorderWidth:2.0];
    [cardButton.layer setCornerRadius:10.0];
    [cardButton addTarget:self action:@selector(cardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardButton];
    //直销银行账户
    UIButton *bankAccountButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 60+1*50+30, SCREEN_WIDTH-10, 50)];
    [bankAccountButton setTitle:@"直销银行卡" forState:UIControlStateNormal];
    [bankAccountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bankAccountButton.layer setBorderWidth:2.0];
    [bankAccountButton.layer setCornerRadius:10.0];
    //    [bankAccountButton addTarget:self action:@selector(cardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bankAccountButton];
    
    //信用卡
    UIButton *creditCardButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 60+2*50+40, SCREEN_WIDTH-10, 50)];
    [creditCardButton setTitle:@"信用卡" forState:UIControlStateNormal];
    [creditCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [creditCardButton.layer setBorderWidth:2.0];
    [creditCardButton.layer setCornerRadius:10.0];
    //    [creditCardButton.layer setBorderColor:(__bridge CGColorRef)([UIColor cyanColor])];
    //    [creditCardButton addTarget:self action:@selector(cardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creditCardButton];
    //无卡
    UIButton *noCardButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 60+3*50+50, SCREEN_WIDTH-10, 50)];
    [noCardButton setTitle:@"无卡" forState:UIControlStateNormal];
    [noCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [noCardButton.layer setBorderWidth:2.0];
    [noCardButton.layer setCornerRadius:10.0];
    //    [noCardButton addTarget:self action:@selector(cardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noCardButton];
    
    
}
//返回button点击事件
- (void)buttonClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}
- (void)cardButtonClicked:(UIButton *)sender{
    cardBinding *vc = [[cardBinding alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
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
