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


+(void)navigatingControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject{
    BSTableContentObject* bs=bsContentObject;
    
    if (!bs.noNeedLoginCheck) {
        BOOL isLogin=[UserManager checkSession];
        if (isLogin==NO) {
            bs=[BSTableContentObject initWithController:viewController storybord:@"LOUserManager"
                identity:@"LOLoginAppViewController"
                canUseStoryboard:YES];
        }
        
        if (bs.canUseStoryboard) {
            //需要修改跳转的Controller
            //将原来的bsContentObject设置为bs的跳转方法
            //
            //bs.method=@"bsContentObject";
            //bsContentObject.vcClass=[NSString stringWithUTF8String:object_getClassName(viewController)];
            bs.neededMethodData=bsContentObject;//没有copy方法则报错
            
            [BSContentObjectNavigation prepareControllWithStorybord:viewController bsContentObject:bs];
        }else{
            [BSContentObjectNavigation prepareControllWithNib:viewController bsContentObject:bs];
        }
        return;
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
        [goControl setValue:bsContentObject.neededMethodData forKeyPath:bsContentObject.method];
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
    
    //不是手工编码根据配置的方法执行具体的方法
    if (bsContentObject.method) {
        [goControl setValue:bsContentObject.neededMethodData forKeyPath:bsContentObject.method];
    }
    
    [viewController.navigationController
        pushViewController:goControl animated:YES];

}


@end
