//
//  BSCommonTabBarController.h
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"

@interface BSUITabBarCommonController : UITabBarController<NavigationProcess,UITextFieldDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

- (void)backClick;
- (void)doneClick;
-(void)navigating:(BSTableContentObject*)bsContentObject;


@end
