//
//  BSContentObjectNavigation.m
//  KTAPP
//  根据BSTableContentOb实现具体的页面跳转
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSContentObjectNavigation.h"
#import <UIKit/UIKit.h>
#import "BSCMFrameworkHeader.h"
#import "UserManager.h"
#import "LOLoginAppViewController.h"

@implementation BSContentObjectNavigation
#pragma mark --登陆工具方法

-(BOOL)checkAndLogin:(UIViewController *)viewController{
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {

       
        
    }
    return isLogin;
}

+(void)navigatingControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    BSTableContentObject* bs=bsContentObject;
    
    if (!bs.noNeedLoginCheck) {
        BOOL isLogin=[UserManager checkSession];
        if (isLogin==NO) {
            bs=[BSTableContentObject initWithController:viewController storybord:@"LOUserManager"
                identity:@"LOLoginAppViewController"
                canUseStoryboard:YES];
        }
    }
    if (bs.canUseStoryboard) {
        [BSContentObjectNavigation prepareControllWithStorybord:viewController bsContentObject:bs];
    }else{
       
        [BSContentObjectNavigation prepareControllWithNib:viewController bsContentObject:bs];
    }
}

/**
 *以故事板实现的Controller的跳转
 */
+(void)prepareControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:bsContentObject.storybordName bundle:nil];
    
    UIViewController *goControl = [storyboard instantiateViewControllerWithIdentifier:bsContentObject.vcClass];
    
    //不是手工编码根据配置的方法执行具体的方法
    if (bsContentObject.method) {
        [goControl setValue:bsContentObject.method forKeyPath:@"method"];
    }

    [viewController.navigationController
        pushViewController:goControl animated:YES];
}

/**
 *以手工方式实现的Controller的跳转
 */
+(void)prepareControllWithNib:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    Class clzz =bsContentObject.colClass;
    UIViewController *goControl =[[clzz alloc] init];
    
    //[viewController presentViewController:goControl animated:NO completion:nil];
    
    [viewController.navigationController
        pushViewController:goControl animated:YES];

}


@end
