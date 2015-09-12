//
//  KCMainViewController.h
//  UIWebView
//
//  Created by Kenshin Cui on 14-3-22.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUICommonController.h"

@interface BSWebViewViewController : BSUICommonController

@property (nonatomic,retain) NSString *requestURL;

//@property (nonatomic,retain) UIToolbar * keyboardToolBar;

#pragma mark -键盘添加事件
//-(void)keyboardDone:(id)sender;
//-(void) delelageForTextField;
@end
