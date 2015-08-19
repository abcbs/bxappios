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
    //获取当前需要显示badgeValue的位置，作为默认的tag，设置tag为-1000，在配置中查找此值。
    
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items{
    
}
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed{
    
    
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController
{
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"KTLBMainTabBarController viewDidAppear 对象的视图已经加入到窗口时调用");
    NSArray *arrays=[BSUIComponentView globleTabBarItemArray];
    //根据配置和通知信息修改TabBar的badgeValue
    if (arrays) {
        UITabBarItem * item=(UITabBarItem *)arrays[2];
        item.badgeValue=@"测";
    }
     [self hideTabBar];
     [self displayTabBar];
}


- (void)hideTabBar {
    [BSUIComponentView initGobleTabBar:self.tabBar];
    self.tabBar.hidden = YES;
    
}

- (void)displayTabBar {
    // self.tabBar.hidden = NO;
    [BSUIComponentView displayGlobleTabBar];
}
- (void)doneClick{
    NSLog(@"TabBar子类应当继承此方法实现完成功能");
    [self displayTabBar];
}

@end
