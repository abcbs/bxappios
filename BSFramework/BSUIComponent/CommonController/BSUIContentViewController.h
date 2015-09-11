//
//  BSUIContentViewController.h
//  KTAPP
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"
#import "BSFCRollingADImageUIView.h"
@interface BSUIContentViewController : UIViewController<NavigationProcess,BSImagePlayerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@property (nonatomic,retain) NSString *inform;

@property (nonatomic,retain)BSTableContentObject * bsContentObject;

@property (nonatomic,retain) UIToolbar * keyboardToolBar;

#pragma mark -键盘添加事件
-(void)keyboardDone:(id)sender;
-(void) delelageForTextField;
-(void) initSubViews;

-(void)configSuggestTextFiled;
@end
