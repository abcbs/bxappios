//
//  BSUICommonController.h
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationProcess.h"
#import "BSFCRollingADImageUIView.H"
@interface BSUICommonController : UIViewController<NavigationProcess,BSImagePlayerDelegate,UITextFieldDelegate,UITextViewDelegate>{
 
}

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@property (nonatomic,retain) NSString *inform;

@property (nonatomic,retain)BSTableContentObject * bsContentObject;

@property (nonatomic,retain) UIToolbar * keyboardToolBar;

@property (strong, nonatomic) NSDictionary *keyBoardDic;

@property (nonatomic,assign) CGRect frameTextFirstResponder;
@property (nonatomic,assign) CGRect scrollViewframe;
@property (nonatomic,assign) CGFloat highOffsetWithKeyBoard;
@property (nonatomic,retain) UIView *scrollViewWithKeyboard;

-(void)configUIViewAndHighOffsetWithKeyBoard;

- (IBAction)View_TouchDown:(id)sender;


/**
 *公共回退方法
 */
- (void)backClick;

/**
 *公共确定方法
 */
- (void)doneClick;

-(BOOL)checkAndLogin;

#pragma mark -键盘添加事件
-(void)keyboardDone:(id)sender;
-(void) delelageForTextField;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;
//地图检查查找所需的TextField
-(void)configSuggestTextFiled;
@end
