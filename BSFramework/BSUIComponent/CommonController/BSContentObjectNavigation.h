//
//  BSContentObjectNavigation.h
//  KTAPP
//  根据BSTableContentOb实现具体的页面跳转
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSUIFrameworkHeader.h"

@interface BSContentObjectNavigation : NSObject

+(void)navigatingControllWithStorybord:(UIViewController *)viewController bsContentObject:(BSTableContentObject*)bsContentObject;


@end
