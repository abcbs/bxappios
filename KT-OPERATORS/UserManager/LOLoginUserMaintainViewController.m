//
//  LOLoginUserMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserMaintainViewController.h"
#import "BSUIFrameworkHeader.h"

@interface LOLoginUserMaintainViewController (){
    NSInteger sex;//1,男 2,女
}

@end

@implementation LOLoginUserMaintainViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];

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
    
    
    //BOOL checkAddress=[[self.address.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""];
    
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
    BSLog(@"数据保存开始");
   
    if (![self checkRightfulData]) {
        //数据验证没有通过通过
        return ;
    }
    
    BSLog(@"数据保存之后");
}

- (IBAction)headerImageClick:(id)sender {
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
@end
