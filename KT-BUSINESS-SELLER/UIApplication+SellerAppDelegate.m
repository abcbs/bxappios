//
//  UIApplication+SellerAppDelegate.m
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIApplication+SellerAppDelegate.h"

@implementation UIApplication (SellerAppDelegate)
/*
-(void)sendEvent:(UIEvent *)event {
    if (event.type==UIEventTypeTouches) {
        if ([[event.allTouches anyObject] phase]==UITouchPhaseBegan) {
            //响应触摸事件（手指刚刚放上屏幕）
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:nScreenTouch object:nil userInfo:[NSDictionary dictionaryWithObject:event
                                                                                                                                                                     forKey:@'data']]];
            //发送一个名为‘nScreenTouch’（自定义）的事件
        }
    }
    //[super sendEvent:event];
}
    
   - (id)initWithFrame:(CGRect)frame {
       self = [super initWithFrame:frame];
       if (self) {
       //注册nScreenTouch事件
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScreenTouch:) name:nScreenTouch object:nil];
       }
       return self;
}

-(void)dealloc {
    //移除nScreenTouch事件
    [[NSNotificationCenter defaultCenter] removeObserver:self
        name:nScreenTouch object:nil];
    //[super dealloc];
}

-(void) onScreenTouch:(NSNotification *)notification {
    UIEvent *event=[notification.userInfo objectForKey:@'data'];
    UITouch *touch=[event.allTouches anyObject];
    if (touch.view!=self) {
    //取到该次touch事件的view，如果不是触摸了selectorView,则隐藏selectorView.
    [UIView animateWithDuration:0.5 animations:^ { self.alpha=0; }]; [UIView commitAnimations];
    }
}
*/
@end

