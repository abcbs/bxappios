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
    [super viewDidLoad];
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    //self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 10, 80);
    //[self.tableView setSeparatorColor:[UIColor blackColor]];
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
                        checkUserName:self.anonName.text];

    if (!checkAnonName) {
        self.anonName.backgroundColor=[UIColor redColor];
        [self.anonName becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"用户名不能为空"];
        return NO;
    }else {
        self.anonName.backgroundColor=defualtColor;
    }
   
    BOOL checkRealName=[BSValidatePredicate
                        checkUserName:self.realName.text];
    
    if (!checkRealName) {
        self.realName.backgroundColor=[UIColor redColor];
        [self.realName becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"真实用户名不能为空"];
        return NO;
    }else{
        self.realName.backgroundColor=defualtColor;
    }
    
    BOOL checkSex=sex!=0;
    if (!checkSex){
        [self.manSex becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"性别没选"];
        return NO;

    }
    
    BOOL checkPassword=[BSValidatePredicate
                        checkPassword:self.password.text];
    
    if (!checkPassword) {
        self.password.backgroundColor=[UIColor redColor];
        [self.password becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"密码6-12位数字和字母组合"];
        return NO;
    }else{
        self.password.backgroundColor=defualtColor;
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
    
    
    BOOL checkAddress=[[self.address.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""];
    
    if (checkAddress) {
        self.address.backgroundColor=[UIColor redColor];
        [self.address becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"详细地址不能为空"];
        return NO;
    }else{
        self.address.backgroundColor=defualtColor;
    }
    
    
    BOOL checkPhone=[BSValidatePredicate
                     checkTelNumber:self.phone.text];
    if (!checkPhone) {
        self.phone.backgroundColor=[UIColor redColor];
        [self.phone becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"手机号11位数字"];
        return NO;
    }else{
        self.phone.backgroundColor=defualtColor;
    }

    BOOL checkNumber=[[self.checkNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""];
    
    if (checkNumber) {
        self.checkNumber.backgroundColor=[UIColor redColor];
        [self.checkNumber becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:@"校验码不能为空"];
        return NO;
    }else{
        self.checkNumber.backgroundColor=defualtColor;
    }
    
    
    if (checkAnonName&&checkRealName&&checkSex&&checkPassword&&checkPhone&&!checkNumber) {
        return YES;
    }
    return NO;
}
- (IBAction)saveLoginUserData:(id)sender {
    BSLog(@"数据保存开始");
   
    if ([self checkRightfulData]) {
        //statements
    }else{
        //[BSUIComponentView confirmUIAlertView:@"信息验证失败，请核实红色字体输入框规定"];
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
