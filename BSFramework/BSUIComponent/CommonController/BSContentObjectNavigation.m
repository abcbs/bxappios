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
@implementation BSContentObjectNavigation

+(void)navigatingControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    if (bsContentObject.canUseStoryboard) {
        [BSContentObjectNavigation prepareControllWithStorybord:viewController bsContentObject:bsContentObject];
    }else{
        [BSContentObjectNavigation prepareControllWithNib:viewController bsContentObject:bsContentObject];
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
    /*
    UINavigationController* nav = [[UINavigationController alloc]  initWithRootViewController:goControl];
    
    [viewController presentViewController:nav animated:YES completion:nil];
     */
    //送水界面此时没有状态栏
    //[viewController.navigationController presentModalViewController:goControl animated:YES];
    [viewController.navigationController pushViewController:goControl animated:YES];
}

/**
 *以手工方式实现的Controller的跳转
 */
+(void)prepareControllWithNib:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    Class clzz =bsContentObject.colClass;
    UIViewController *goControl =[[clzz alloc] init];
    
    //[viewController presentViewController:goControl animated:NO completion:nil];
    
    [viewController.navigationController pushViewController:goControl animated:YES];

}


@end
