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
@interface BSUICommonController : UIViewController<NavigationProcess,BSImagePlayerDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

/**
 *公共回退方法
 */
- (void)backClick;
/**
 *公共确定方法
 */
- (void)doneClick;

@end
