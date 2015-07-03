//
//  KTLBMainTabBarController.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLBMainTabBarController.h"
#import "BSUIFrameworkHeader.h"

@interface KTLBMainTabBarController ()

@end

@implementation KTLBMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSArray *controllers=self.viewControllers;
    //NSArray *views= self.view.subviews;
    //[self hideTabBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"KTLBMainTabBarController viewDidAppear 对象的视图已经加入到窗口时调用");
    //[self hideTabBar];
}


- (void)hideTabBar {
    if (self.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBar.frame.size.height);
    self.tabBar.hidden = YES;
    
}


- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
}

@end
