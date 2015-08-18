//
//  AppDelegate.m
//  民生小区
//
//  Created by L on 15/4/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AppDelegate.h"
//#import "KTTarBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"
#import "KTLBMainTabBarController.h"

@interface AppDelegate ()
    
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
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
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //网络日志监控
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    //网络可用性监控
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //网络变化监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    //默认颜色
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor = [UIColor redColor];
    //一级页面统一的处理方式
    //获取tabBar
   	UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    [BSUIComponentView initTabBarWithDefault:tabBarController];
    //id<UITabBarDelegate> tabBardDelegate=tabBarController;
    //KTLBMainTabBarController *kt=[[KTLBMainTabBarController alloc]init];
    //kt.delegate=tabBardDelegate;
    //设置导航栏颜色
    //[BSUIComponentView navigationHeader:self.window.rootViewController.navigationController];
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    
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


#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
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

#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

#pragma mark - 私有方法
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
@end






