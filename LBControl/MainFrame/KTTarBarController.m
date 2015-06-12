//
//  KTTarBarController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTTarBarController.h"
#import "KTLifeSearchBar.h"
#import "KTlifeViewController.h"
#import "SetViewController.h"

@interface KTTarBarController ()

/**
 *  搜索框
 */
@property (nonatomic, weak) KTLifeSearchBar *searchBar;
@end

@implementation KTTarBarController
-(instancetype)init
{
    if (self = [super init]){
       
}

     return self;
}



-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        
        KTlifeViewController *life = [self addControllerWithClass:[KTlifeViewController class] title:@"生活服务" nomalimage:@"shfwh"selectedImage:@"shfws"];
       
        UINavigationController *lifeNav = [[UINavigationController alloc]initWithRootViewController:life];
        
        UIViewController *shops = [self addControllerWithClass:[UIViewController class] title:@"信誉商家" nomalimage:@"xysjh" selectedImage:@"xysjs"];
        UINavigationController *shopsNav = [[UINavigationController alloc]initWithRootViewController:shops];
        
        UIViewController *service = [self addControllerWithClass:[UIViewController class] title:@"便捷服务" nomalimage:@"bjfw" selectedImage:@"bjfwh"];
        UINavigationController *serviceNav = [[UINavigationController alloc]initWithRootViewController:service];
        SetViewController *circle = [self addControllerWithClass:[SetViewController class] title:@"我的圈子" nomalimage:@"wdqzh" selectedImage:@"wdqzs"];
        UINavigationController *circleNav = [[UINavigationController alloc]initWithRootViewController:circle];
       

        self.viewControllers = @[life, shops, service,circle];

        
    }
    return self;
    
    
    
}
-(UIViewController*)addControllerWithClass:(Class)class title: (NSString *)title nomalimage:(NSString *)nomalimage selectedImage:(NSString *)selectedImage
{
   
    UIViewController *vc = [[class alloc] init];
 
    return [self addControllerWithVc:vc title:title nomalimage:nomalimage selectedImage:selectedImage];
    
    
}




-(UIViewController *)addControllerWithVc:(UIViewController *)vc title:(NSString *)title nomalimage:(NSString *)nomalimage selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title  = title;
    vc.tabBarItem.image = [UIImage imageNamed:nomalimage];
    
    //1.创建图片
    UIImage *newImage = [UIImage imageNamed:selectedImage];
    //2. 告诉系统原样显示
    newImage = [newImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //3.设置图片
    vc.tabBarItem.selectedImage = newImage;
    vc.view.backgroundColor = [UIColor clearColor];
    
  
    // 自定义titile的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:173/255.0 green:173/255.0 blue:175/255.0 alpha:1], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:117/255.0 green:1/255.0 blue:1/255.0 alpha:1], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    return vc;
}
@end
