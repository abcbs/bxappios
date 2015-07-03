//
//  cleaning.m
//  民生小区
//
//  Created by 闫青青 on 15/6/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "cleaning.h"
#import "Conf.h"
#import "UIView+SZ.h"
#import "addressController.h"
@interface cleaning ()//UITextField *text4
@property (nonatomic,strong) UIButton*button1;
@property (nonatomic,strong) UIButton *addressBtn;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UITextField *text1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UITextField *text2;
@property (nonatomic,strong) UIView *line3;
@property (nonatomic,strong) UITextField *text3;
@property (nonatomic,strong) UIView *line4;
@property (nonatomic,strong) UIButton * confirm;
@property (nonatomic,strong) UITextView *text4;
@property (nonatomic,strong) UITextField *text5;
@property (nonatomic,strong) UIButton *tijiaoButton;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation cleaning

- (void)viewDidLoad {
    [super viewDidLoad];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-270, 65)];
    NSString *imageName = [NSString stringWithFormat:@"yyfw9_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.048125, self.view.bounds.size.width*0.048125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //地址栏
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 70,SCREEN_WIDTH-10,120)];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor grayColor]CGColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, 50, 30)];
    address.text = @"地址:";
    address.font = [UIFont fontWithName:nil size:15];
    [view addSubview:address];
    UILabel *address1 = [[UILabel alloc]initWithFrame:CGRectMake(56, 10, 100, 30)];
    address1.text = @"西直门";
    address1.font = [UIFont fontWithName:nil size:15];
    [view addSubview:address1];
    UILabel *people = [[UILabel alloc]initWithFrame:CGRectMake(6, 40, 70, 30)];
    people.text = @"联系人:";
    people.font = [UIFont fontWithName:nil size:15];
    [view addSubview:people];
    UILabel *people1 = [[UILabel alloc]initWithFrame:CGRectMake(76, 40, 100, 30)];
    people1.text = @"罗芳芳";
    people1.font = [UIFont fontWithName:nil size:15];
    [view addSubview:people1];
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(6, 70, 90, 30)];
    phone.text = @"联系电话:";
    phone.font = [UIFont fontWithName:nil size:15];
    [view addSubview:phone];
    UILabel *phone1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 70, 100, 30)];
    phone1.text = @"13695440782";
    phone1.font = [UIFont fontWithName:nil size:15];
    [view addSubview:phone1];
    UILabel *defaults = [[UILabel alloc]initWithFrame:CGRectMake(200, 90, 60, 30)];
    defaults.text = @"默认信息";
    defaults.font = [UIFont fontWithName:nil size:15];
    [view addSubview:defaults];
    //单选按钮
    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(265, 89, 25, 25)];
    [_button1 setImage:[UIImage imageNamed:@"a3"] forState:UIControlStateNormal];
    [_button1 setImage:[UIImage imageNamed:@"a4"] forState:UIControlStateHighlighted];
    [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_button1];
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(265, 40, 20, 20)];
    [nextBtn setImage:[UIImage imageNamed:@"im_information_you"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextBtn];
    //添加新地址
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(5, 200,SCREEN_WIDTH-10,175)];
    _view1.layer.borderWidth = 1;
    _view1.layer.borderColor = [[UIColor grayColor]CGColor];
    _view1.layer.masksToBounds = YES;
    _view1.layer.cornerRadius = 5;
    [self.view addSubview:_view1];
    _addressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    [_addressBtn setTitle:@"添加新地址+" forState:UIControlStateNormal];
    [_addressBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(addressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_addressBtn];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH-10, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [_view1 addSubview:line];
    _text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 30)];
    _text1.text = @"姓名:";
    [_view1 addSubview:_text1];
    _line2 = [[UIView alloc]initWithFrame:CGRectMake(5, 60, SCREEN_WIDTH-10, 1)];
    _line2.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [_view1 addSubview:_line2];
    _text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, 30)];
    _text2.text = @"地址:";
    [_view1 addSubview:_text2];
    _line3 = [[UIView alloc]initWithFrame:CGRectMake(5, 90, SCREEN_WIDTH-10, 1)];
    _line3.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [_view1 addSubview:_line3];
    _text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-20, 30)];
    _text3.text = @"联系方式:";
    _line4 = [[UIView alloc]initWithFrame:CGRectMake(5, 120, SCREEN_WIDTH-10, 1)];
    _line4.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.5];
    [_view1 addSubview:_line4];
    [_view1 addSubview:_text3];
    _confirm = [[UIButton alloc]initWithFrame:CGRectMake(120, 122, 80, 25)];
    [_confirm setImage:[UIImage imageNamed:@"im_information_add.png"] forState:UIControlStateNormal];
    [_view1 addSubview:_confirm];
    
    _text4 = [[UITextView alloc]initWithFrame:CGRectMake(5, 360, SCREEN_WIDTH-10, 50)];
    _text4.layer.borderWidth = 1;
    _text4.layer.cornerRadius = 8;
    //_text4.placeholder = @"请输入预约时间";
    NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
    [formatDate setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    [formatDate setDateFormat:@"yyyy-MM-dd HH:mm"];
    nowDate = [NSDate date];
    _text4.text = @"请输入预约时间";
     _text4.font = [UIFont systemFontOfSize:20];
    _text4.textColor = [UIColor lightGrayColor];
    _text4.textContainerInset = UIEdgeInsetsZero;
    UIButton *btn = [UIButton  buttonWithType:UIButtonTypeCustom];
    btn.frame = _text4.bounds;
    btn.backgroundColor = [UIColor clearColor];
    
    [_text4 addSubview:btn];
    [btn addTarget:self action:@selector(cellTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_text4];
    _text5 = [[UITextField alloc]initWithFrame:CGRectMake(5, 415, SCREEN_WIDTH-10, 90)];
    _text5.layer.borderWidth = 1;
    _text5.layer.cornerRadius = 8;
    _text5.placeholder = @"请输入预约描述...";
    [self.view addSubview:_text5];
    _tijiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 410, 110, 40)];
    [_tijiaoButton setImage:[UIImage imageNamed:@"tjdd00.png"] forState:UIControlStateNormal];
    [self.view addSubview:_tijiaoButton];
    _view1.height = 30;
    _text4.y = CGRectGetMaxY(_view1.frame)+10;
    _text5.y = CGRectGetMaxY(_text4.frame)+10;
    _tijiaoButton.y = CGRectGetMaxY(_text5.frame)+10;
    
    dateView.frame = [[UIScreen mainScreen] bounds];
    pick.backgroundColor = [UIColor whiteColor];
    //    [self initFView];
    //    [self initFscrollview];
    dateView.frame = self.view.bounds;
    currentDateItem = 1;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    pick.locale = locale;
    
    
}
-(void)cellTouchAction:(UIButton *)btn{
    dateView.hidden = NO;
    currentDateItem = 1;
}
- (IBAction)selectedDate:(UIButton *)btn{
    NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
    [formatDate setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    [formatDate setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSComparisonResult result;
    if (currentDateItem==1)
    {
        result = [[pick date] compare:[NSDate date]];
        if (result == NSOrderedDescending) {
            _text4.text = [formatDate stringFromDate:pick.date];
            _text4.textColor = [UIColor blackColor];
        }
    }
    else
    {
        result = [[pick date] compare:nowDate];
    }
    
    dateView.hidden = YES;
    
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_text5 resignFirstResponder];
    [_text4 resignFirstResponder];

}

- (void)next:(UIButton *)sender{
    addressController *vc = [[addressController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}
//点击 添加新地址 按钮
//- (void)addressButtonClicked:(UIButton *)sender{
//    BOOL isClick = self.addressBtn.isSelected;
//
//    if(isClick){
//        [UIView animateWithDuration:0.5 animations:^{
//            _view1.height = 150;
//            _text4.y = CGRectGetMaxY(_view1.frame);
//            _text5.y  = CGRectGetMaxY(_text4.frame);
//        }];
//
//        [self.addressBtn setSelected:NO];
//
//    }
//    else {
//        [UIView animateWithDuration:0.5 animations:^{
//            _view1.height = 30;
//            _text4.y = CGRectGetMaxY(_view1.frame);
//            _text5.y = CGRectGetMaxY(_text4.frame);
//        }];
//        [self.addressBtn setSelected:YES];
//    }
//}
- (void)addressButtonClicked:(UIButton *)sender{
    BOOL isClick = self.addressBtn.isSelected;
    if(isClick){
        [UIView animateWithDuration:0.5 animations:^{
            _view1.height = 30;
            _text4.y = CGRectGetMaxY(_view1.frame)+10;
            _text5.y = CGRectGetMaxY(_text4.frame)+10;
            _tijiaoButton.y = CGRectGetMaxY(_text5.frame)+10;
        }];
        [self.addressBtn setSelected:NO];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            _view1.height = 150;
            _text4.y = CGRectGetMaxY(_view1.frame)+10;
            _text5.y  = CGRectGetMaxY(_text4.frame)+10;
            _tijiaoButton.y = CGRectGetMaxY(_text5.frame)+10;
        }];
        
        [self.addressBtn setSelected:YES];
    }
}
//单选按钮
- (void)buttonClicked:(UIButton *)sender{
    if (_isSelect) {
        [_button1 setImage:[UIImage imageNamed:@"a3"] forState:UIControlStateNormal];
        _isSelect = NO;
    }else{
        [_button1 setImage:[UIImage imageNamed:@"a4"] forState:UIControlStateNormal];
        _isSelect = YES;
        
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
