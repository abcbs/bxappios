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
    [self hideTabBar];
    
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    
}
/**
 *控制哪些 ViewController 的标签栏能被点击
 */
- ( BOOL )tabBarController:( UITabBarController *)tabBarController shouldSelectViewController :( UIViewController *)viewController{
    NSLog(@"KTLBMainTabBarController tabBarController:shouldSelectViewController");
    
    return YES;
    
}

// 选中哪个标签栏
- ( void )tabBarController:( UITabBarController *)tabBarController didSelectViewController :( UIViewController *)viewController{
    
    NSLog(@"KTLBMainTabBarController tabBarController:didSelectViewController");

    
}
/*
 *More view controller 编辑
 */
- ( void )tabBarController:( UITabBarController *)tabBarController
didEndCustomizingViewControllers :( NSArray *)viewControllers
                   changed:( BOOL )changed{
    
    NSLog(@"KTLBMainTabBarController tabBarController:didEndCustomizingViewControllers:changed");

    
}

// More view controller 将要开始编辑
- ( void )tabBarController:( UITabBarController *)tabBarController willBeginCustomizingViewControllers :( NSArray *)viewControllers{
    NSLog(@"KTLBMainTabBarController tabBarController:willBeginCustomizingViewControllers");

}

// More view controller 将要结束编辑

- ( void )tabBarController:( UITabBarController *)tabBarController willEndCustomizingViewControllers :( NSArray *)viewControllers changed:( BOOL )changed{
    NSLog(@"KTLBMainTabBarController tabBarController:willEndCustomizingViewControllers:changed");

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"KTLBMainTabBarController tabBar:didSelectItem");
    tabBar.tintColor=[BSUIComponentView  navigationColor];
    
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items{
    
}
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed{
    
    
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed{
    
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items {
   
    
    UIView *l2 = [self.view.subviews objectAtIndex:1];
    UINavigationBar *l3_0=[l2.subviews objectAtIndex:0];
    //l3_0代表 configure UINavigationBar
    [l3_0 setBarStyle:UIBarStyleBlack];
    UINavigationItem *rightButton=(UINavigationItem *)[l3_0.subviews objectAtIndex:2];
    //rightButton代表 configure UINavigationBar右侧按钮
    rightButton.title=@"完成";
    
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
    
    self.tabBar.hidden = NO;
    
}


- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
}

@end
