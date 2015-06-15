//
//  enquireController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "enquireController.h"
#import "Conf.h"
@interface enquireController ()

@end

@implementation enquireController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.1];
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
    //下面的view
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 150)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, 180, 30)];
    address.text = @"XX银行XX路支行";
    address.font = [UIFont fontWithName:nil size:17];
    [view1 addSubview:address];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 40, SCREEN_WIDTH-10, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [view1 addSubview:line];
    UILabel *date1 = [[UILabel alloc]initWithFrame:CGRectMake(6, 41, 180, 30)];
    date1.text = @"对私工作日营业时间:";
    date1.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:date1];
    UILabel *time1 = [[UILabel alloc]initWithFrame:CGRectMake(160, 41, 180, 30)];
    time1.text = @"09:00--17:00";
    time1.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:time1];

    UILabel *date2 = [[UILabel alloc]initWithFrame:CGRectMake(6, 75, 180, 30)];
    date2.text = @"对私工作日营业时间:";
    date2.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:date2];
    UILabel *time2 = [[UILabel alloc]initWithFrame:CGRectMake(160, 75, 180, 30)];
    time2.text = @"09:00--17:00";
    time2.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:time2];
    UILabel *date3 = [[UILabel alloc]initWithFrame:CGRectMake(6, 110, 180, 30)];
    date3.text = @"对私工作日营业时间:";
    date3.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:date3];
    UILabel *time3 = [[UILabel alloc]initWithFrame:CGRectMake(160, 110, 180, 30)];
    time3.text = @"09:00--17:00";
    time3.font = [UIFont fontWithName:nil size:15];
    [view1 addSubview:time3];
    //view2
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 230, SCREEN_WIDTH, 80)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(6, 5, 180, 30)];
    phone.text = @"电话:  600405556";
    phone.font = [UIFont fontWithName:nil size:15];
    [view2 addSubview:phone];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(250, 5, 30, 30)];
    [btn1 setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [view2 addSubview:btn1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(5, 35, SCREEN_WIDTH-10, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [view2 addSubview:line2];
    UILabel *ads = [[UILabel alloc]initWithFrame:CGRectMake(6, 45, 180, 30)];
    ads.text = @"地址:  西直门外大街18号";
    ads.font = [UIFont fontWithName:nil size:15];
    [view2 addSubview:ads];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(250, 45, 30, 30)];
    [btn2 setImage:[UIImage imageNamed:@"dizhi"] forState:UIControlStateNormal];
    [view2 addSubview:btn2];
    //
    UILabel *standard = [[UILabel alloc]initWithFrame:CGRectMake(6, 320, SCREEN_WIDTH, 30)];
    standard.text = @"当前排队人数仅供参考，具体情况以实际为准!";
    standard.font = [UIFont fontWithName:nil size:15];
    [self.view addSubview:standard];
    //
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, 80)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    //uiimageView
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img1 setImage:[UIImage imageNamed:@"vip"]];
    [view3 addSubview:img1];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 40, 40)];
    [img2 setImage:[UIImage imageNamed:@"putong"]];
    [view3 addSubview:img2];
    //UILabel
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 3, 180, 40)];
    lab1.text = @"客户排队:0";
    lab1.font = [UIFont fontWithName:nil size:15];
    [view3 addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 38, 180, 40)];
    lab2.text = @"客户排队:1";
    lab2.font = [UIFont fontWithName:nil size:15];
    [view3 addSubview:lab2];
    //label
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(110, 445, 150, 20)];
    lab.text = @"更新时间:18:00";
    lab.font = [UIFont fontWithName:nil size:15];
    [self.view addSubview:lab];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 480, 120, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"paiduiquhao"] forState:UIControlStateNormal];
    [self.view addSubview:button];
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
