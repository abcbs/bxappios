//
//  BSCommonTabBarController.h
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"

@interface BSUITabBarCommonController : UITabBarController<NavigationProcess,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@property (nonatomic,retain) UIToolbar * keyboardToolBar;

- (void)backClick;
- (void)doneClick;
-(void)navigating:(BSTableContentObject*)bsContentObject;

#pragma mark -键盘添加事件
-(void)keyboardDone:(id)sender;
-(void) delelageForTextField;
-(void)configSuggestTextFiled;
@end
