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
@interface BSUIContentViewController : UIViewController<NavigationProcess,BSImagePlayerDelegate>

@property (nonatomic,assign)BOOL bDisplaySearchButtonNav;

@property (nonatomic,assign)BOOL bDisplayReturnButtonNav;

@end
