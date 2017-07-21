//
//  recommendguest.m
//  民生小区
//
//  Created by 闫青青 on 15/6/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "recommendguest.h"
#import "Conf.h"
@interface recommendguest ()
{
    NSString *i;
}
@property (strong,nonatomic) UITextField *userTextField;
@property (strong,nonatomic) UITextField *realNameText;
@property (strong,nonatomic) UITextField *creditCardText;
@property (strong,nonatomic) UITextField *mailText;
@property (strong,nonatomic) UITextField *phoneText;
@property (strong,nonatomic) UITextField *addressText;
@property (nonatomic,strong) UIButton*button1;
@property (nonatomic,strong) UIButton*button2;

@end

@implementation recommendguest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.1];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"tjkh_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //完成按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.78125, SCREEN_HEIGHT*0.052916, SCREEN_WIDTH*0.140625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register-2.png"] forState:UIControlStateNormal];
    //[commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    //下面的输入框和label
    NSArray *array = @[@"   用 户 名:",@"   真实姓名:",@"   性  别:",@"   身份证:",@"   电子邮件:",@"   手机号:",@"   地址:"];
    for(int i = 0;i <7;i++){
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.28125, SCREEN_HEIGHT*0.083)];
        label.text = array[i];
        label.font = [UIFont fontWithName:nil size:15];
        label.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
        label.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:label];
      }
    //usertext
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*0, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _userTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_userTextField];
    //realNameText
    _realNameText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*1, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _realNameText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_realNameText];
    //白色背景
    UIView *backImage = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*2, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    backImage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backImage];
    //单选按钮
    _button1 = [self createButtonwithframe:CGRectMake(SCREEN_WIDTH*0.30625, SCREEN_HEIGHT*0.335, SCREEN_WIDTH*0.12625, SCREEN_HEIGHT*0.05208) image:@"RadioButton-Unselected" seletedImage:@"RadioButton-Selected"];
    //_button1.selected = YES;
    _button2 = [self createButtonwithframe:CGRectMake(SCREEN_WIDTH*0.50625, SCREEN_HEIGHT*0.335, SCREEN_WIDTH*0.12625, SCREEN_HEIGHT*0.05208) image:@"RadioButton-Unselected" seletedImage:@"RadioButton-Selected"];
    [self.view addSubview:_button2];
    [self.view addSubview:_button1];
    //性别男Label
    UILabel *man = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4225, SCREEN_HEIGHT*0.335, SCREEN_WIDTH*0.0675, SCREEN_HEIGHT*0.05208)];
    man.text = @"男";
    man.font = [UIFont fontWithName:nil size:15];
    man.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
    man.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:man];
    //性别女Label
    UILabel *woman = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.6225, SCREEN_HEIGHT*0.335, SCREEN_WIDTH*0.0675, SCREEN_HEIGHT*0.05208)];
    woman.text = @"女";
    woman.font = [UIFont fontWithName:nil size:15];
    woman.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
    woman.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:woman];
    //validateCodeText
    _creditCardText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*3, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _creditCardText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_creditCardText];
   
    //commitCode
    _mailText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*4, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _mailText.backgroundColor = [UIColor whiteColor];
    _mailText.secureTextEntry = YES;
    [self.view addSubview:_mailText];
    //phoneText
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*5, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _phoneText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_phoneText];
    //addressText
    _addressText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*6, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _addressText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_addressText];
}
//单选按钮
-(UIButton*)createButtonwithframe:(CGRect)frame image:(NSString*)imageName seletedImage:(NSString*)seletedImageName{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =frame;
    UIImage*image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    UIImage*selecteIamge = [UIImage imageNamed:seletedImageName];
    [selecteIamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:selecteIamge forState:UIControlStateSelected];
    return button;
}
-(NSInteger)buttonClicked:(UIButton*)button{
    if (button==_button1) {
        _button1.selected = YES;
        _button2.selected = NO;
        i = @"0";
        NSLog(@"返回0");
        return 0;
    }else{
        _button1.selected = NO;
        _button2.selected = YES;
        NSLog(@"返回1");
        i = @"1";
        return 1;
    }
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
