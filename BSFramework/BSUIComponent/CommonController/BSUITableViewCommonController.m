//
//  BSUITableViewCommonController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"

@implementation BSUITableViewCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BSUIComponentView initNavigationHeaderWithDefault:self
                                     navigationProcess:self title:nil
     ];
    [BSUIComponentView navigationHeader:self.navigationController];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"BSUICommonController viewDidAppear 对象的视图已经加入到窗口时调用");

}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
}

/**
 *页面跳转公共方法
 */
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}

@end
