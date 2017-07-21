//
//  LOLoginUserMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserMaintainViewController.h"
#import "BSIFTTHeader.h"

@interface LOLoginUserMaintainViewController ()<UITextFieldDelegate,BSPhotoTakeDelegate,UIAlertViewDelegate>{
    NSInteger sex;//1,男 2,女
    BOOL isEdit;
    BOOL isHeaderImage;
    //商品头像图
    __block Resources *rs;
    
    UIAlertView *alert;

}

@end

@implementation LOLoginUserMaintainViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    
    //图片选择与拍照
    self.takeController = [[BSPhotoTakeController alloc] init];
    self.takeController.delegate = self;
    
    [self delelageForTextField];
    
    [self initSubViews];
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *数据装载
 */
- (void)setupData
{
    if (self.loginUser)
    {
        isEdit = YES;
        self.anonName.text=self.loginUser.username;
        self.realName.text=self.loginUser.realName;
        self.phone.text=self.loginUser.phoneNum;
        self.password.text=self.loginUser.password;
        self.againPassword.text=self.loginUser.password;
        self.address.text=self.loginUser.address;
        
        if ([self.loginUser.sex  isEqualToString:@"1"]) {
            self.manSex.selected=YES;
            self.womenSex.selected=NO;
            sex=1;
        }else if([self.loginUser.sex  isEqualToString:@"2"]){
            self.manSex.selected=NO;
            self.womenSex.selected=YES;
            sex=2;
        }
        //商品头像
        if (self.loginUser.headerImage) {
            self.headerImage.image=self.loginUser.headerImage;
        }else{
            self.headerImage.image=[UIImage imageNamed:@"a9-xiao-120.png"];
        }

    }
}
-(void)clearDisplayView{
    
    //匿名，用户名
    self.anonName.text=nil;
    
    self.headerImage.image=nil;
    
    //真实姓名
    self.realName.text=nil;

    //密码
    self.password.text=nil;

    //确认明明
    self.againPassword.text=nil;

    //地址
    self.address.text=nil;

    
    //手机号
    self.phone.text=nil;

    //验证码
    self.checkNumber.text=nil;
    
    //图片
    self.headerImage.image=[UIImage imageNamed:@"a9-xiao-120.png"];

}


#pragma mark --键盘关闭处理
#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘
-(void)delelageForTextField{
    self.realName.delegate=self;
    //匿名，用户名
    self.anonName.delegate=self;
    //真实姓名
    self.realName.delegate=self;
    //密码
    self.password.delegate=self;
    //确认明明
    self.againPassword.delegate=self;
    //地址
    self.address.delegate=self;
    
    //手机号
    self.phone.delegate=self;
    //验证码
    self.checkNumber.delegate=self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


-(BOOL) checkRightfulData{
   
    UIColor *defualtColor=[UIColor lightTextColor];
    BOOL checkAnonName=[BSValidatePredicate
                        checkUserNameField:self.anonName alert:@"用户名不能为空"];
    if (!checkAnonName) {
        return NO;
    }

    BOOL checkRealName=[BSValidatePredicate
                        checkUserNameField:self.realName alert:@"真实用户名不能为空"];
    
    if (!checkRealName) {
        return NO;
    }
    
    
    BOOL checkSex=sex!=0;
    if (!checkSex){
        [self.manSex becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"性别没选"];
        return NO;

    }
    
    BOOL checkPassword=[BSValidatePredicate
                        checkPasswordField:self.password];
    
    if (!checkPassword) {
        return NO;
    }
    

    BOOL checkAgainPassword=[self.password.text
                             isEqual:self.againPassword.text];
    if (!checkAgainPassword) {
        self.againPassword.backgroundColor=[UIColor redColor];
        [self.againPassword becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"密码不一致"];
        return NO;
    }else{
        self.againPassword.backgroundColor=defualtColor;
    }
      
    BOOL checkAddress=[BSValidatePredicate checkNilField:self.address
                                                   alert:@"详细地址不能为空"];
    if (!checkAddress) {
        return NO;
    }
    
    BOOL checkPhone=[BSValidatePredicate
                     checkTelNumberField:self.phone];
    if (!checkPhone) {
        return NO;
    }
    BOOL checkNumber=[BSValidatePredicate checkNilField:self.checkNumber
                                                  alert:@"校验码不能为空"];
    
    if (!checkNumber) {
        return NO;
    }
    
    if (checkAnonName&&checkRealName&&checkSex&&checkPassword&&checkPhone&&checkNumber) {
        return YES;
    }
    return NO;
}

- (IBAction)saveLoginUserData:(id)sender {
    [self saveData];
}

-(void)saveData{
    if (![self checkRightfulData]) {
        return;
    }
    self.loginUser.username=self.anonName.text;
    self.loginUser.realName=self.realName.text;
    self.loginUser.sex=[NSString stringWithFormat:@"%ld", sex];
   
    self.loginUser.password= self.password.text;
    self.loginUser.commitCode=self.againPassword.text;
    self.loginUser.address=self.address.text;
    self.loginUser.phoneNum=self.phone.text;
    if (self.headerImage.image) {
            self.loginUser.headerImage=self.headerImage.image;
    }
    //防止重复提交，保存按钮去掉
    self.navigationItem.rightBarButtonItem = nil;
    //营业执照
    if (isEdit) {
        [self.editDelegate editedLoginUser:self.loginUser  blockArray:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
       
    }
    if (!isEdit)
    {
        //用户注册，由TabBar进入
        self.loginUser=[LoginUser new];
        self.loginUser.username=self.anonName.text;
        self.loginUser.realName=self.realName.text;
        self.loginUser.sex=[NSString stringWithFormat:@"%ld", sex];
        
        self.loginUser.password= self.password.text;
        self.loginUser.commitCode=self.againPassword.text;
        self.loginUser.address=self.address.text;
        self.loginUser.phoneNum=self.phone.text;
        if (self.headerImage.image) {
            self.loginUser.headerImage=self.headerImage.image;
        }

        if (self.editDelegate) {
            [self.editDelegate addLoginUser:self.loginUser
                                 blockArray:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                                     [self nextData];
                                 }];
        }else{//由TabBar进入得应当到登陆界面
            UserManager *um=[UserManager userManager];
            [um insertLoginUser:self.loginUser
                     blockArray:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                         alert =[self displayAlert];
                         [alert show];
                     }
             ];
            
        }
        
    }
   
    
}

-(void)toPageController{
    [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController"
    canUseStoryboard:YES];
    
}
- (void)nextData
{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.loginUser=nil;
    self.loginUser=[LoginUser new];
    [self modifiedStyle];
    [self initSubViews];
    [self clearDisplayView];
}

- (void)initSubViews
{
    isEdit=NO;
    //Button样式修改
    [BSUIComponentView configButtonStyle:self.headerImageButton];
    [BSUIComponentView configButtonStyle:self.checkNumberButton];
    //图片样式修改
    [BSUIComponentView configImageStyle:self.headerImage];
    //输入框样式调整
    [BSUIComponentView configTextField:self.anonName];
    [BSUIComponentView configTextField:self.realName];
    [BSUIComponentView configTextField:self.password];
    [BSUIComponentView configTextField:self.address];
    [BSUIComponentView configTextField:self.phone];
    [BSUIComponentView configTextField:self.againPassword];
    [BSUIComponentView configTextField:self.checkNumber];
    
}

- (IBAction)headerImageClick:(id)sender {
    [self.takeController takeSinglePhotoOrChooseFromLibrary];

}

- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    BSLog(@"取消拍照动作操作");
}

- (UIViewController *)takeController:(BSPhotoTakeController *)controller{
    return self;
}

- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(Resources *)info
{
    rs=info;
    [self.headerImage setImage:photo];
}

- (IBAction)phoneCheckNumberClick:(id)sender {
}

- (IBAction)menSexClick:(id)sender {
    BSLog(@"性别男选中");
    self.manSex.selected=YES;
    self.womenSex.selected=NO;
    sex=1;//
    
}

- (IBAction)womanSexClick:(id)sender {
    BSLog(@"性别女选中");
    self.manSex.selected=NO;
    self.womenSex.selected=YES;
    sex=2;//
}

#pragma marks -- UIAlertViewDelegate --
-(UIAlertView *)displayAlert{
    return[[UIAlertView alloc] initWithTitle:@"注册成功"
                               message:@""
                              delegate:self
                     cancelButtonTitle:@"返回"
                     otherButtonTitles:@"登陆",nil];
  
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];

    }else if(buttonIndex==1){
        [self toPageController];
    }
}

@end
