//
//  LOLoginAppViewController.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginAppViewController.h"
#import "BSCMFrameworkHeader.h"
#import "LBModelsHeader.h"
#import "BSIFTTHeader.h"
@interface LOLoginAppViewController ()<UITextFieldDelegate>
{
    LoginUser *loginUser;
    NSInteger loginNumber;
    UIAlertView *alert;
}
@end

@implementation LOLoginAppViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
   
    [self delelageForTextField];
    [self initSubViews];
}

- (void)initSubViews
{

    [BSUIComponentView configButtonStyle:self.loginButton];
    [BSUIComponentView configButtonStyle:self.resetPasswordButton];
    [BSUIComponentView configTextField:self.password];
    [BSUIComponentView configTextField:self.account];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)modifiedStyle{
    self.resetPasswordButton.backgroundColor=[BSUIComponentView navigationColor];
    self.loginButton.backgroundColor=[BSUIComponentView navigationColor];
}

#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘
-(void)delelageForTextField{
    self.account.delegate=self;
    self.password.delegate=self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetPasswordClick:(id)sender {
    
}
-(BOOL) checkRightfulData{
    
    //UIColor *defualtColor=[UIColor lightTextColor];
    BOOL checkAnonName=[BSValidatePredicate
            checkNilField:self.account alert:@"账户不能为空"];
    if (!checkAnonName) {
        return NO;
    }
    BOOL checkPassword=[BSValidatePredicate
             checkPasswordField:self.password alert:@"密码不能为空"];
    if (!checkPassword) {
        return NO;
    }
    if (checkAnonName&&checkPassword) {
        return YES;
    }
    return NO;
}
- (IBAction)loginClick:(id)sender {
    if (![self checkRightfulData]) {
        return;
    }
    loginNumber++;
    if (loginNumber>USER_LONGIN_NUMBER) {
        [BSUIComponentView confirmUIAlertView:@"登陆密码点击超过%ld次,已经锁住，请联系运维人员解锁"];
        return;
    }
    BSSecurity *security=[BSSecurity sharedBSSecurity];
    NSString *encrAcc=[security encryptString:self.account.text];
    BSLog(@"加密账户信息为:\t%@",encrAcc);
    
    NSString *decrAcc=[security decryptString:encrAcc];
     BSLog(@"解密账户信息为:\t%@",decrAcc);
    loginUser=[LoginUser new];
    loginUser.userName=self.account.text;
    loginUser.passWord=self.password.text;
    UserManager *um=[UserManager userManager];
    [um loginWithUser:loginUser blockArray:^(NSObject *response, NSError *error, ErrorMessage *errorMessage) {
      
        UserSession *userSession=(UserSession*)response;
        [UserManager registSession:userSession];
        //便捷的数据保存方式
        //NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        //[userDefaults setObject:sessionId forKey:@"sessionId"];
        //
        [self.navigationController popViewControllerAnimated:YES];

     }
    ];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma marks -- UIAlertViewDelegate --
-(UIAlertView *)displayAlert:(NSString *)cancleTitle otherButtonTitle:()otherTitle{
    return[[UIAlertView alloc] initWithTitle:cancleTitle
                                     message:@""
                                    delegate:self
                           cancelButtonTitle:cancleTitle
                           otherButtonTitles:otherTitle,nil];
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(buttonIndex==1){
        //[self toPageController];
    }
}
@end
