//
//  RegistUtil.h
//  民生小区
//
//  Created by 闫青青 on 15/5/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSValidatePredicate : NSObject
#pragma 正则匹配手机号,请输入正确的手机号(11)位数字
+ (BOOL)checkTelNumber:(NSString *) telNumber;
+ (BOOL)checkTelNumberField:(UITextField *) phone;
+ (BOOL)checkTelNumberField:(UITextField *) phone alert:(NSString *)prompt;

#pragma 正则匹配用户密码6-12位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
+ (BOOL)checkPasswordField:(UITextField *) password;
+ (BOOL)checkPasswordField:(UITextField *) password alert:(NSString *)prompt;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
+ (BOOL)checkUserNameField : (UITextField *) userName ;
+ (BOOL)checkUserNameField : (UITextField *) userName alert:(NSString *)prompt;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

#pragma mark -判断是否为空
+ (BOOL)checkNil:(NSString *) field;
+ (BOOL)checkNilField:(UITextField *) field;
+ (BOOL)checkNilField:(UITextField *) field alert:(NSString *)prompt;

+ (BOOL)checkNumber : (NSString *) number;
@end
