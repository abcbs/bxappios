//
//  BSUIComponentView.h
//  KTAPP
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "BSUIFrameworkHeader.h"
#import "BSUIBarButtonItem.h"
#import "BSUIBlockButton.h"

@interface BSUIComponentView : NSObject

/**
 *显示确定和取消两种按钮
 */
+(void)confirmUIAlertView:(NSString *)title
                  message:(NSString *)message
                     name:(NSString *)name;

/**
 *显示确定按钮
 */
+(void)confirmUIAlertView:message;

/**
 * 导航页颜色
 */
+(UIColor *)navigationColor;

+(UIColor *)backgroundColor;
/**
  *默认改变iOS提供工具栏的颜色，如TableViewController
  *应用实例：KTlifeViewController
  */
+(void)navigationHeader:(UINavigationController *)navigationController;

/**
 *使用图像自定义头部信息
 *应用实例：communicate.h
 */
+(UIImageView *)navigationHeaderWithImage:(NSString *)imageName;

/**
 *头部信息加入默认标题
 *示例，我的圈子主页
 */
+(void)navigationHeaderWithImage:(NSString *)imageName view:(UIView *)view;

/**
 *头部默认信息
 *此表头有两个按钮，返回和确定
 */
+(void)initNarHeaderWithDefault:(UIViewController *)currentController
                          title:(NSString *)title;


+(void)initNarHeaderWithIndexView:(UIViewController *)currentController
                            title:(NSString *)title;


+(void )initNavigationHeaderWithDefault:(UIViewController *)viewController
                      navigationProcess:(id<NavigationProcess>) navigationProcess
                                  title:(NSString *)title;


+(BSUIBarButtonItem *)backBarButtonItem:(id<NavigationProcess>) navigationProcess target:(UIViewController *)target title:(NSString *)title image:(NSString *)image;


+(BSUIBarButtonItem *)okBarButtonItem:(id<NavigationProcess>) navigationProcess  target:(UIViewController *)target title:(NSString *)title image:(NSString *)image;

+(void)initTableNarHeaderWithDefault:(BSUICommonController *)currentController
                           tableView:(UITableView *)tableView
                               title:(NSString *)title;

/**
 *默认TabBar初始化方法
 */
+(void)initTabBarWithDefault:(UITabBarController *)tabBarController;

+(void)changeTabBarWithNotification:(UIViewController *)uiViewController addedInfo:(NSString *)info;


@end
