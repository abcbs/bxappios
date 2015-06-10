//
//  LoginViewController.h
//  民生小区
//
//  Created by 闫青青 on 15/4/23.
//  Copyright (c) 2015年 闫青青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginMessage.h"
@interface LoginViewController : UIViewController<LoginMessage>
//@property (strong, nonatomic) NSString *sessionID;
@property (strong, nonatomic) NSDictionary *errorLogin;
//接收登录message
@property (strong, nonatomic) NSString *loginMessage;


@end
