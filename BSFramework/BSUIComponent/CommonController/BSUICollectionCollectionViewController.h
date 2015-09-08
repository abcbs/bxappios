//
//  BSUICollectionCollectionViewController.h
//  KTAPP
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"
@interface BSUICollectionCollectionViewController : UICollectionViewController<NavigationProcess,UITextFieldDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@property (nonatomic,retain) NSString *inform;

@property (nonatomic,retain)BSTableContentObject * bsContentObject;
/**
 *返回方法
 */
- (void)backClick;
/**
 *默认操作，默认为检索操作
 */
- (void)doneClick;

- (void)navigating:(BSTableContentObject*)bsContentObject;

@end
