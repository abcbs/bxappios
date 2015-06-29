//
//  BSUICommonController.h
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationProcess.h"

@interface BSUICommonController : UIViewController<NavigationProcess>

@property(nonatomic, strong) NSString *navTitle;

- (void)backClick;
- (void)doneClick;

@end
