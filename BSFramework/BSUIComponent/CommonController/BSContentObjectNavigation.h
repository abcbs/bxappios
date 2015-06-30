//
//  BSContentObjectNavigation.h
//  KTAPP
//  根据BSTableContentOb实现具体的页面跳转
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSUIFrameworkHeader.h"

@interface BSContentObjectNavigation : NSObject


/**
 *在故事板跳转中，BSTableContentObject中的storybordName和vcClass不能为空。
 */
+(void)prepareControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject;

/**
 *以手工方式实现的Controller的跳转
 */
+(void)prepareControllWithNib:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject;

@end
