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

@interface BSUIComponentView : NSObject

+(void)confirmUIAlertView:(NSString *)title
                  message:(NSString *)message
                     name:(NSString *)name;

+(void)confirmUIAlertView:message;
@end
