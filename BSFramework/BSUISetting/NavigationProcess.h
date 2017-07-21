//
//  NavigationProcess.h
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTableContentObject.h"
@protocol NavigationProcess <NSObject>

/**
 *公共返回方法，默认返回到前一页
 */
- (void)backClick;

/**
 *公共确定，默认为搜索功能
 */
- (void)doneClick;

/**
 *权限修改规定方法
 */
-(void)modifiedStyle;

/**
 *登陆判断
 */
-(BOOL)checkAndLogin;
/**
 *公共导航到下一页Controller
 */
-(void)navigating:(BSTableContentObject*)bsContentObject;

-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard;

-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check;
@end
