//
//  cardBinding.m
//  民生小区
//
//  Created by 闫青青 on 15/5/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "cardBinding.h"
#import "Conf.h"
#import "userProtocol.h"
@interface cardBinding ()
{
    NSString *i;
}
@property (nonatomic, strong)UIButton *button1;

@end

@implementation cardBinding

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    //下一步按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.78125, SCREEN_HEIGHT*0.060916, SCREEN_WIDTH*0.150625, SCREEN_HEIGHT*0.04508)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"银行卡绑定-1.png"] forState:UIControlStateNormal];
//    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    //添加TextField
    NSArray *array = @[@"   卡号",@"   卡类型",@"   姓名",@"   证件类型",@"   证件号码",@"   手机号码",@"   密码"];
    for(int i = 0;i <7;i++){
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.28125, SCREEN_HEIGHT*0.083)];
        label.text = array[i];
        label.font = [UIFont fontWithName:nil size:15];
        label.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
        
        label.backgroundColor = [UIColor whiteColor];
        //        label.layer.shadowColor = [UIColor blackColor].CGColor;
        //        label.layer.shadowOpacity = 1.0;
        //        label.layer.shadowRadius = 2.0;
        //        label.layer.shadowOffset = CGSizeMake(0, 2);
        //        label.clipsToBounds = NO;
        [self.view addSubview:label];
        //textField
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2925, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.7075-10, SCREEN_HEIGHT*0.083)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = i;
        [self.view addSubview:textField];
    }
    UIButton *protocolButton = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT*0.1548+SCREEN_HEIGHT*0.09075*7, SCREEN_WIDTH-20, SCREEN_HEIGHT*0.083)];
    [protocolButton setTitle:@"      用户协议" forState:UIControlStateNormal];
    [protocolButton setTitleColor:[UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5] forState:UIControlStateNormal];
    protocolButton.backgroundColor = [UIColor whiteColor];
    [protocolButton.layer setBorderWidth:2.0];
    [protocolButton.layer setBorderColor:(__bridge CGColorRef)([UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.1])];
    [protocolButton.layer setCornerRadius:10.0];
    [protocolButton addTarget:self action:@selector(protocol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolButton];
    //单选按钮
    _button1 = [self createButtonwithframe:CGRectMake(SCREEN_WIDTH*0.17625, SCREEN_HEIGHT*0.1708+SCREEN_HEIGHT*0.09075*7, SCREEN_WIDTH*0.15625, SCREEN_HEIGHT*0.05208) image:@"RadioButton-Unselected" seletedImage:@"RadioButton-Selected"];
    [self.view addSubview:_button1];
    
}
//返回button点击事件
- (void)buttonClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}
//用户协议
- (void)protocol:(UIButton *)sender{
    userProtocol *uVC = [[userProtocol alloc]init];
    [self presentViewController:uVC animated:NO completion:nil];
}
//单选按钮
-(UIButton*)createButtonwithframe:(CGRect)frame image:(NSString*)imageName seletedImage:(NSString*)seletedImageName{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =frame;
    UIImage*image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    UIImage*selecteIamge = [UIImage imageNamed:seletedImageName];
    [selecteIamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:selecteIamge forState:UIControlStateSelected];
    return button;
}

-(NSInteger)btnClicked:(UIButton*)button{
    if (button==_button1) {
        _button1.selected = YES;
        i = @"0";
        NSLog(@"返回0");
        }
    return 0;
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
