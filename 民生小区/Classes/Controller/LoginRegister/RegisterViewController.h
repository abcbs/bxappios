//
//  RegisterViewController.h
//  民生小区
//
//  Created by 闫青青 on 15/4/23.
//  Copyright (c) 2015年 闫青青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendMessage.h"
@interface RegisterViewController : UIViewController<SendMessage>
//取图片的base-64
@property (strong, nonatomic) NSString *contents;
//注册错误信息
@property (strong, nonatomic) NSDictionary *errorRegist;
//获取验证码错误信息
@property (strong, nonatomic) NSDictionary *errorValidateCode;
//上传头像错误信息
@property (strong, nonatomic) NSDictionary *errorHeadImage;
//传入message
@property (strong, nonatomic) NSString *message;
//传入获取验证码的message
@property (strong, nonatomic) NSString *validateMsg;

@end
