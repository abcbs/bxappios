//
//  BSUIComponentView.m
//  KTAPP
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIComponentView.h"
#define CONFIRM_TITLE @"错误提示"
#define CONFIRM_BUTTON_NAME @"确定"

@implementation BSUIComponentView

static BSUIComponentView *instance=nil;

+(BSUIComponentView *) instance
{
    if (instance==nil) {
        instance=[[super allocWithZone:nil] init];
    }
    return instance;
}

+(void)confirmUIAlertView:(NSString *)title
                  message:(NSString *)message
                     name:(NSString *)name{
    
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:title                                                  message:message
        delegate:nil
        cancelButtonTitle:name
        otherButtonTitles:nil];
    
    [alert show];
}

+(void)confirmUIAlertView:message
{
    [self confirmUIAlertView:CONFIRM_TITLE
    message:message
                   name:CONFIRM_BUTTON_NAME];
    
}



@end
