#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)  //无网

#import "SellerAppDelegate.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"
#import <BaiduMapAPI/BMapKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "PromptInfo.h"
#import <MAMapKit/MAMapKit.h>

@interface SellerAppDelegate () < UIApplicationDelegate,BMKGeneralDelegate> {
}

@end

BMKMapManager* _mapManager;

BSNetworkNotify *networkNotify;

@implementation SellerAppDelegate

#pragma mark -首次运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BSLog(@"\n/*=---------------App首次运行\n\t\tdidFinishLaunchingWithOptions\n-------------------=*/");
    // Override point for customization after application launch.
    //网络日志监控
    //[[AFNetworkActivityLogger sharedLogger] startLogging];
    //网络可用性监控
//    AFNetworkActivityIndicatorManager *networkActivityIndicatorManager=[AFNetworkActivityIndicatorManager sharedManager];
//    [networkActivityIndicatorManager setEnabled:YES];
//    
//    
//    networkNotify=[BSNetworkNotify sharedBSNetworkNotify];
//    
//    [networkNotify startNetworkReachability];
    //默认颜色
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor = [UIColor redColor];
    
    //一级页面统一的处理方式
    //获取tabBar
   	UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    [BSUIComponentView initTabBarWithDefault:tabBarController];
    
    //程序运行在前台，消息正常显示
    //应用的三种
    //UIApplicationStateActive,
    //UIApplicationStateInactive,
    //UIApplicationStateBackground
    //从而使得我们的应用可以接受到推送通知。步骤如下：
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    
//    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
//        [self addLocalNotification];//如果已经获得发送通知的授权则创建本地通知
//    }else{
//        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
//    }
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    //百度地图应用名称KT_PIO
    //百度地图安全码abc.KT-OPERATORS
    //Bundle display name:$(PRODUCT_NAME)或者其他文字，此项不能为空，否则启动失败
//    
//     BOOL ret = [_mapManager start:@"8bCZR8tPTI7QvoxWNefbTzIN" generalDelegate:self];
//     if (!ret) {
//     BSLog(@"/*=--------APP百度地图启动失败------------+=/");
//     }else{
//     BSLog(@"/*=--------APP百度地图启动成功------------+=/");
//     
//     }
    
//    //高德地图
//    [MAMapServices sharedServices].apiKey =@"b4b17852c2a8bac769b3af0aed171dec";
//    
//    //注册设备
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    //设置消息推送
//    [BSTRPushHelper setupWithOptions:launchOptions];
//    
//     //接收通知参数
//     UILocalNotification *notification=[launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//     NSDictionary *userInfo= notification.userInfo;
//     
//     //[userInfo writeToFile:@"/Users/kenshincui/Desktop/didFinishLaunchingWithOptions.txt" atomically:YES];
//     NSLog(@"didFinishLaunchingWithOptions:The userInfo is %@.",userInfo);
    
    //NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    
//    if (launchOptions) {
//        NSString *pushString =  [NSString stringWithFormat:@"%@", launchOptions];
//
//        NSString *url= [[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"url"];
//        //appDelegate.push= url;
//        
//        NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        
//    }
    return YES;
}

#pragma mark -多次打开应用执行的两个方法-再次打开1
#pragma mark -再次运行
-(void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    BSLog(@"\n/*=---------------App再次运行\n\t\tapplicationWillEnterForeground\n-------------------=*/");

}


#pragma mark -首次运行方法
#pragma mark -再次运行都执行下面的方法-再次打开-2
#pragma mark -当程序复原时， 此委托方法会被调用，在此你可以通过之前挂起前保存的数据来恢复你的应用程序
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //注应用程序在启动时，调用了applicationDidFinishLaunching方法之后也会调用此方法，所以确保代码能够分清复原与启动.
    BSLog(@"\n/*=---------------App首次(再次)运行\n\t\tapplicationDidBecomeActive\n-------------------=*/");
//    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
//    
//    [networkNotify startNetworkReachability];
}

#pragma mark -下面是关闭时执行的两个方法-首次（再次）关闭1
#pragma mark -再次关闭
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //系统将要停止，适当保存数据，当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
//    BSLog(@"\n/*=---------------App首次（再次）关闭\n\t\tapplicationWillResignActive\n-------------------=*/");
//    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
//    
//    [networkNotify stopNetworkReachability];
    
}

#pragma mark -关闭--首次（多次）终止2
- (void)applicationDidEnterBackground:(UIApplication *)application{
//    BSLog(@"\n/*=---------------App关闭\n\t\tapplicationDidEnterBackground\n-------------------=*/");
//    [self execBackrgoundMethod];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while(TRUE)
//        {
//            [NSThread sleepForTimeInterval:1];
//            
//            //编写执行任务代码
//            BSLog(@"后台执行中");
//        }
        
        //[application endBackgroundTask: background_task];
        //background_task = UIBackgroundTaskInvalid;
//    });

}

#pragma mark -关机
#pragma mark -系统将要停止，适当保存数据--首次关闭执行2
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用此方法。但是如果长主按钮强制退出，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作：
    BSLog(@"\n/*=---------------App关闭\n\t\tapplicationWillTerminate\n-------------------=*/");
    
}

/*
 禁止横屏
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark 接收本地通知时触发
-(void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification{
    //空实现，有Bug
    //[BSTRPushHelper showLocalNotificationAtFront:notification];
//    NSDictionary *userInfo=notification.userInfo;
//    NSLog(@"didReceiveLocalNotification:The userInfo is %@",userInfo);
    /*
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到本地推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
     */
    
//    UIApplicationState state = [application applicationState];
//    if (state == UIApplicationStateInactive) {
//        //这个通知用户已经看过了。
//    }else{
//        application.applicationIconBadgeNumber = 0;
//        //NSString *reminderText = [notification.userInfo
//        //                          objectForKey:kRemindMeNotificationDataKey];
//        //NSLog(@"%@",reminderText);
//
//    }
//    
//    if (application.applicationState != UIApplicationStateActive)
//     {
//            
//           
//      
//       [self.window.rootViewController presentViewController:nil animated:YES completion:nil];
//                    
//           
//      }
//   
//    //订阅展示视图消息，将直接打开某个分支视图
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView:) name:@"PresentView" object:nil];
//    //弹出消息框提示用户有订阅通知消息。主要用于用户在使用应用时，弹出提示框
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotification:) name:@"Notification" object:nil];
}

#pragma mark -远程通知方法
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
//    BSLog(@"远程注册成功:\t%@",newDeviceToken);
//    //注册成功，将deviceToken保存到应用服务器数据库中
//    [BSTRPushHelper registerDeviceToken:newDeviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    BSLog(@"注册失败:\t%@",error);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 处理推送消息
//    BSLog(@"\n/*=---------------处理远程推送消息:\n\t%@\n\t\t\n-------------------=*/",userInfo);
//    BSLog(@"收到推送消息:%@",
//          [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
//    [BSTRPushHelper handleRemoteNotification:userInfo completion:nil];
    /*
    if (application.applicationState == UIApplicationStateActive) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到远程推送消息"
                                                    message:userInfo[@"aps"][@"alert"]
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [alert show];
    */
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification
                   :(NSDictionary *)userInfo fetchCompletionHandler
                   :(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[BSTRPushHelper handleRemoteNotification:userInfo completion:completionHandler];
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    /*
     if (application.applicationState == UIApplicationStateActive) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到远程推送消息"
     message:userInfo[@"aps"][@"alert"]
     delegate:nil
     cancelButtonTitle:@"取消"
     otherButtonTitles:@"确定", nil];
     [alert show];
     }
     */
}
#endif

#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
/*
 -(void)application:(UIApplication *)application
 didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
 if (notificationSettings.types!=UIUserNotificationTypeNone) {
 [self addLocalNotification];
 }
 }
 */
//#pragma mark - 私有方法
//#pragma mark 添加本地通知
//-(void)addLocalNotification{
//    
//    //定义本地通知对象
//    UILocalNotification *notification=[[UILocalNotification alloc]init];
//    //设置调用时间
//    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
//    notification.repeatInterval=2;//通知重复次数
//    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
//    
//    //设置通知属性
//    notification.alertBody=@"本地新功能"; //通知主体
//    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
//    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
//    //notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
//    
//    //设置用户信息
//    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
//    
//    //调用通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
// 
//}
//
//#pragma mark 移除本地通知，在不需要此通知时记得移除
//-(void)removeNotification{
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//}
//#pragma mark 通知机制接口结束
//
//#pragma mark -百度地图运行状态测试开始
//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        BSLog(@"APP联网成功");
//    }
//    else{
//        BSLog(@"APP联网失败 %d",iError);
//        [PromptInfo showWithText:@"APP联网失" topOffset:54 duration:2];
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        BSLog(@"APP授权成功");
//    }
//    else {
//        BSLog(@"APP授权失败 %d",iError);
//        [PromptInfo showWithText:@"APP授权失败" topOffset:54 duration:2];
//    }
//}
//
//
//
//-(void)execBackrgoundMethod
//{
//    /*
//     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//     */
//    [[UIApplication sharedApplication] applicationState]; //app状态
//    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:3600]; //设置后台运行时间
//    NSTimeInterval remainTime = [[UIApplication sharedApplication] backgroundTimeRemaining]; //app后台运行的时间
//    NSLog(@"remainTIme = %f",remainTime);
//    int state = [[UIApplication sharedApplication] backgroundRefreshStatus]; //后台刷新的状态
//    NSLog(@"state = %d",state);
//    [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"taskOne" expirationHandler:^{
//        NSLog(@"后台运行中taskOne");
//
//    }];
//    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        NSLog(@"后台运行中");
//
//        
//    }];
//    [[UIApplication sharedApplication] endBackgroundTask:1];
//    
//    
//    UIApplication* app = [UIApplication sharedApplication];
//    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        //app endBackgroundTask:bgTask];
//        //bgTask = UIBackgroundTaskInvalid;
//        NSLog(@"后台运行中//////////////////");
//        [self addLocalNotification];
//        [self scheduleAlarmForDate:nil];
//        
//    }];
//
//    // Start the long-running task and return immediately.
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
//                                             0), ^{
//        NSLog(@"后台运行中//////////////////");
//        //在这里写你要在后运行行的代码
//        //[app endBackgroundTask:bgTask];
//        //bgTask = UIBackgroundTaskInvalid;
//    });
//}
//
//- (void)scheduleAlarmForDate:(NSDate*)theDate
//{
//    //theDate延迟多长时间弹出
//    UIApplication* app = [UIApplication sharedApplication];
//    NSArray* oldNotifications = [app scheduledLocalNotifications];
//    // Clear out the old notification before scheduling a new one.
//    if ([oldNotifications count] > 0)
//        [app cancelAllLocalNotifications];
//    // Create a new notification.
//    UILocalNotification* alarm = [[UILocalNotification alloc] init];
//    if (alarm)
//    {
//        alarm.fireDate = theDate;
//        alarm.timeZone = [NSTimeZone defaultTimeZone];
//        alarm.repeatInterval = 0;
//        alarm.soundName = @"alarmsound.caf";
//        alarm.alertBody = @"Time to wake up!";
//        [app scheduleLocalNotification:alarm];
//    }
//}

@end