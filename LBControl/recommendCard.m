//
//  recommendCard.m
//  民生小区
//
//  Created by 闫青青 on 15/6/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "recommendCard.h"
#import "Conf.h"
#import "DropDownListView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
@interface recommendCard ()
{
    NSMutableArray *chooseArray ;
    
}
@property (strong,nonatomic) UIScrollView *BigScrollView;
@property (strong,nonatomic) UITextField *user;
@property (strong,nonatomic) UITextField *cardType;
@property (strong,nonatomic) UITextField *cardNum;
@property (strong,nonatomic) UITextField *birthDate;
@property (strong,nonatomic) UITextField *country;
@property (strong,nonatomic) UITextField *receiveAddress;
@property (strong,nonatomic) UITextField *postCode;
@property (strong,nonatomic) UITextField *monthIncome;
@property (strong,nonatomic) UITextField *phoneNum;
@property (strong,nonatomic) UITextField *officeNum;
@property (strong,nonatomic) UITextField *houseNum;
@property (strong,nonatomic) UITextField *mail;
@end

@implementation recommendCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.1];
    //scrollView
    _BigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth,kScreenHight)];
    _BigScrollView.contentSize=CGSizeMake(kScreenWidth,kScreenHight + 400);
    _BigScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _BigScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_BigScrollView];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"tjkk_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [_BigScrollView addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [_BigScrollView addSubview:backButton];
    //完成按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.78125, SCREEN_HEIGHT*0.052916, SCREEN_WIDTH*0.140625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register-2.png"] forState:UIControlStateNormal];
    //[commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_BigScrollView addSubview:commitButton];
    
    //下面的输入框和label
    NSArray *array = @[@"  姓名:",@"  证件类型:",@"  证件号码:",@"  出生日期:",@"  国家/省/市:",@"  接到地址:",@"  邮政编码:",@"  个人月收入:",@"  手机号码:",@"  办公电话:",@"  家庭电话:",@"  电子邮件:"];
    for(int i = 0;i <12;i++){
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.28125, SCREEN_HEIGHT*0.083)];
        label.text = array[i];
        label.font = [UIFont fontWithName:nil size:15];
        label.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
        label.backgroundColor = [UIColor whiteColor];
        [_BigScrollView addSubview:label];
    }
    //user
    _user = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*0, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _user.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_user];
    //cardType
//    _cardType = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*1, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
//    _cardType.backgroundColor = [UIColor whiteColor];
//    [_BigScrollView addSubview:_cardType];
    //cardNum
    _cardNum = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*2, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _cardNum.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_cardNum];
    //birthDate
    _birthDate = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*3, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _birthDate.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_birthDate];
    //country
    _country = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*4, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _country.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_country];
    //receiveAddress
    _receiveAddress = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*5, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _receiveAddress.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_receiveAddress];
    //postCode
    _postCode = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*6, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _postCode.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_postCode];
    //monthIncome
    _monthIncome = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*7, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _monthIncome.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_monthIncome];
    //phoneNum
    _phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*8, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _phoneNum.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_phoneNum];
    //officeNum
    _officeNum = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*9, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _officeNum.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_officeNum];
    //houseNum
    _houseNum = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*10, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _houseNum.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_houseNum];
    //mail
    _mail = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*11, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _mail.backgroundColor = [UIColor whiteColor];
    [_BigScrollView addSubview:_mail];
    chooseArray = [NSMutableArray arrayWithArray:@[@[@"身份证",@"社保证"]]];
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.1348+SCREEN_HEIGHT*0.09075*1, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [_BigScrollView addSubview:dropDownView];
    
}
#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%ld ,index:%ld",(long)section,(long)index);
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

- (void)buttonClickeds:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
