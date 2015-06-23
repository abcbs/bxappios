//
//  AppDelegate.m
//  民生小区
//
//  Created by L on 15/4/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "KTTarBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import "Conf.h"

@interface AppDelegate ()
    
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //float iosVersion=IOS_VERSION;
    
    if(IS_IPHONE5){
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
        
    }else if (IS_IPHONE_6PLUS){
        myDelegate.autoSizeScaleX = 1.29375;
        myDelegate.autoSizeScaleY=1.2957;
 
    }else if(IS_IPHONE_6){
        myDelegate.autoSizeScaleX=1.171875;
        myDelegate.autoSizeScaleY=1.17429577;
    }else {
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;

    }
    
    // Override point for customization after application launch.
    //添加第三方平台
    [ShareSDK registerApp:@"768dff8dce18"];
    //短信分享功能
    [ShareSDK connectSMS];
    //添加新浪微博应用 注册网址 http://open.weibo.com
    //    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
    //                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
    //                             redirectUri:@"http://www.sharesdk.cn"];
    //添加微信应用 注册网址 http://open.weixin.qq.com
    //    [ShareSDK connectWeChatWithAppId:@"wxc94aa1ef40e14232"
    //                           wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wxc94aa1ef40e14232"
                           wechatCls:[WXApi class]];
    //微信登陆的时候需要初始化
    //    [ShareSDK connectWeChatWithAppId:@"wxc94aa1ef40e14232"
    //                           appSecret:@"005bd65c9c2cdbafa5327c5d101a2dc4"
    //                           wechatCls:[WXApi class]];
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    //    [ShareSDK connectQZoneWithAppKey:@"100371282"
    //                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
    //                   qqApiInterfaceCls:[QQApiInterface class]
    //                     tencentOAuthCls:[TencentOAuth class]];
    
    // 1.初始化自定义Log

     //默认颜色
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor = [UIColor redColor];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 禁止横屏
 */
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

//storyBoard view自动适配
+ (void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = BSRectMake(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = BSRectMake(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
        }
    }
}


@end






