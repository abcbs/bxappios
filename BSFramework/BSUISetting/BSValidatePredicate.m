//
//  RegistUtil.m
//  民生小区
//
//  Created by 闫青青 on 15/5/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSValidatePredicate.h"
#import "BSUIFrameworkHeader.h"

@implementation BSValidatePredicate

#pragma mark -正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString * pattern = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

+ (BOOL)checkTelNumberField:(UITextField *) phone{
    return [BSValidatePredicate checkTelNumberField:phone alert:nil];
}
+ (BOOL)checkTelNumberField:(UITextField *) phone alert:(NSString *)prompt{
    UIColor *defualtColor=[UIColor lightTextColor];
    NSString *alertText=prompt;
    if (!alertText) {
        alertText=@"手机号11位数字";
    }
    BOOL checkPhone=[BSValidatePredicate
                     checkTelNumber:phone.text];
    if (!checkPhone) {
        phone.backgroundColor=[UIColor redColor];
        [phone becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:alertText];
        return NO;
    }else{
        phone.backgroundColor=defualtColor;
    }
    return YES;
}

#pragma mark -正则匹配用户密码6-12位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    //^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$"
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
+ (BOOL)checkPasswordField:(UITextField *) password{
    return [BSValidatePredicate checkPasswordField:password alert:nil];
}
+ (BOOL)checkPasswordField:(UITextField *) password alert:(NSString *)prompt{
    NSString *alertText=prompt;
    if (!alertText) {
        alertText=@"密码6-12位数字和字母组合";
    }
    BOOL checkPassword=[BSValidatePredicate
                        checkPassword:password.text];
     UIColor *defualtColor=[UIColor lightTextColor];
    if (!checkPassword) {
        password.backgroundColor=[UIColor redColor];
        [password becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:alertText];
        return NO;
    }else{
        password.backgroundColor=defualtColor;
    }
    return YES;
}
#pragma mark -正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserNameField : (UITextField *) userName{
    return [BSValidatePredicate checkUserNameField:userName alert:nil];
}
+ (BOOL)checkUserNameField : (UITextField *) userName alert:(NSString *)prompt {
    NSString *alertText=prompt;
    if (!alertText) {
        alertText=@"此项不能为空";
    }
    UIColor *defualtColor=[UIColor lightTextColor];
    BOOL checkAnonName=[BSValidatePredicate
                        checkUserName:userName.text];
    
    if (!checkAnonName) {
        userName.backgroundColor=[UIColor redColor];
        [userName becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:alertText];
        return NO;
    }else {
        userName.backgroundColor=defualtColor;
    }
    return YES;
}

+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

#pragma mark -正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

//
+ (BOOL)checkNumber : (NSString *) number
{
    NSScanner* scan = [NSScanner scannerWithString:number];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
#pragma mark -正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma mark -正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma mark -正则匹配URL
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark -判断是否为空
+ (BOOL)checkNil:(NSString *) field{
    BOOL check=[[field stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""];
    return check;
}
+ (BOOL)checkNilField:(UITextField *) field{
    return [BSValidatePredicate checkNilField:field alert:nil];
    
}
+ (BOOL)checkNilField:(UITextField *) field alert:(NSString *)prompt{
    NSString *alertText=prompt;
    if (!alertText) {
        alertText=@"此项不能为空";
    }
    UIColor *defualtColor=[UIColor lightTextColor];
    BOOL checkAddress=[BSValidatePredicate checkNil:field.text];
    
    if (checkAddress) {
        field.backgroundColor=[UIColor redColor];
        [field becomeFirstResponder];
        [BSUIComponentView confirmUIAlertView:alertText];
        return NO;
    }else{
        field.backgroundColor=defualtColor;
    }
    return YES;
}
@end
