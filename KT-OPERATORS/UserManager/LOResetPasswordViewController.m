//
//  LOResetPasswordViewController.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOResetPasswordViewController.h"
#import <MessageUI/MessageUI.h>
@interface LOResetPasswordViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation LOResetPasswordViewController

- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    [self initSubViews];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews
{
    
    [BSUIComponentView configButtonStyle:self.checkNumberButton];

    [BSUIComponentView configTextField:self.password];
    [BSUIComponentView configTextField:self.againPassword];
    [BSUIComponentView configTextField:self.phone];
    [BSUIComponentView configTextField:self.checkNumber];
    
    //
     [self.checkActivityIndicator stopAnimating];
}

-(void)setupData{
    if (self.loginUser) {
        self.phone.text=self.loginUser.username;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)savePasswordData:(id)sender {
}

#pragma mark -短信获取校验码
- (IBAction)checkNumberClick:(id)sender {
    //去后台获取
    [self.checkActivityIndicator startAnimating];
}

-(void)sendSMS{
    //[self openOutside:sender];
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    if (canSendSMS)
    {
        //创建短信视图控制器
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        //设置代理，代理方法实现对短信发送状态的监控（成功，失败，取消）
        picker.messageComposeDelegate = self;
        //设置短信内容
        picker.body = @"test";
        
        //设置发送的电话，
        picker.recipients = [NSArray arrayWithObject:@"13600001234"];
        //打开短信功能
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        [BSUIComponentView confirmUIAlertView:@"iOS版本过低,iOS4.0以上才支持程序内发送短信，必须使用真机测试"];
    }

}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result)
    {
        case MessageComposeResultCancelled:
            BSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            BSLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
            
            break;
        default:
            BSLog(@"Result: SMS not sent");
            break;
    }
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openOutside:(id)sender
{
    //调用打电话功能
    //[[UIApplicationsharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
    
    //调用发短信功能
    //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10000"]];
    

    NSURL *numberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:1360001234"]];
    //判断程序是否可以打开短信功能
    if ([[UIApplication sharedApplication] canOpenURL:numberURL])
    {
        [[UIApplication sharedApplication] openURL:numberURL];
    } else
    {
        NSLog(@"无法打开短信功能");
    }
    
}
@end
