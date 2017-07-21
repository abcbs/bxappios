//
//  ClassForSelectors.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "ClassForSelectors.h"
#import <UIKit/UIKit.h>


@implementation ClassForSelectors

- (void) fooNoInputs {
    NSLog(@"Does nothing");
}
- (void) fooOneIput:(NSString*) first {
    NSLog(@"Logs %@", first);
}
- (void) fooFirstInput:(NSString*) first secondInput:(NSString*) second {
    NSLog(@"Logs %@ then %@", first, second);
}

- (NSArray *)abcWithAAA: (NSNumber *)number {
    int primaryKey = [number intValue];
    NSLog(@"%i", primaryKey);
    return nil;
}

- (void) performMethodsViaSelectors {
    [self performSelector:@selector(fooNoInputs)];
    [self performSelector:@selector(fooOneIput:) withObject:@"first"];
    [self performSelector:@selector(fooFirstInput:secondInput:) withObject:@"first" withObject:@"second"];
}

#pragma mark - UI事件
//打电话
- (IBAction)callClicK:(UIButton *)sender {
    NSString *phoneNumber=@"18500138888";
    //    NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];//这种方式会直接拨打电话
    NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];//这种方式会提示用户确认是否拨打电话
    [self openUrl:url];
}

//发送短信
- (IBAction)sendMessageClick:(UIButton *)sender {
    NSString *phoneNumber=@"18500138888";
    NSString *url=[NSString stringWithFormat:@"sms://%@",phoneNumber];
    [self openUrl:url];
}

//发送邮件
- (IBAction)sendEmailClick:(UIButton *)sender {
    NSString *mailAddress=@"kenshin@hotmail.com";
    NSString *url=[NSString stringWithFormat:@"mailto://%@",mailAddress];
    [self openUrl:url];
}

//浏览网页
- (IBAction)browserClick:(UIButton *)sender {
    NSString *url=@"http://www.cnblogs.com/kenshincui";
    [self openUrl:url];
}

//打开第三方应用
- (IBAction)thirdPartyApplicationClick:(UIButton *)sender {
    NSString *url=@"cmj://myparams";
    [self openUrl:url];
}

#pragma mark - 私有方法
-(void)openUrl:(NSString *)urlStr{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSString *str=[NSString stringWithFormat:@"url:%@,source application:%@,params:%@",url,sourceApplication,[url host]];
    [str writeToFile:@"/Users/cuijiangtao/Desktop/1.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",str);
    return YES;//是否能够打开
}
@end

