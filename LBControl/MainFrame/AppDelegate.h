//
//  AppDelegate.h
//  民生小区
//
//  Created by L on 15/4/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property float autoSizeScaleX;
@property float autoSizeScaleY;


+(void)storyBoradAutoLay:(UIView *)allView;


@end

CG_INLINE CGRect BSRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}


CG_INLINE CGSize BSSizeMake(CGFloat width, CGFloat height){
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGSize size;
    size.height=size.width = width * myDelegate.autoSizeScaleX;
    size.height = height * myDelegate.autoSizeScaleY;
    return size;
    
}

CG_INLINE CGFloat BSMarginX(CGFloat x){
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    return  x / myDelegate.autoSizeScaleX;
    
}


CG_INLINE CGFloat BSMarginY(CGFloat y){
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    return  y / myDelegate.autoSizeScaleY;
    
}


