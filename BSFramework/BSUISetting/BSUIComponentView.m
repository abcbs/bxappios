//
//  BSUIComponentView.m
//  KTAPP
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIComponentView.h"
#import "BSUIFrameworkHeader.h"
#import "BSUIBlockButton.h"
#import "BSUIBarButtonItem.h"

#define CONFIRM_TITLE @"错误提示"
#define CONFIRM_BUTTON_NAME @"确定"

UITabBarController * rootTabBarController;

@interface BSUIComponentView (){
    }

@property (strong,nonatomic) UIViewController *rootUIViewController;

@end

@implementation BSUIComponentView


/**
 *显示确定和取消两种按钮
 */
+(void)confirmUIAlertView:(NSString *)title
                  message:(NSString *)message
                     name:(NSString *)name{
    
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:title                                                  message:message
        delegate:nil
        cancelButtonTitle:name
        otherButtonTitles:nil];
    
    [alert show];
}

/**
 *显示确定按钮
 */
+(void)confirmUIAlertView:message
{
    [self confirmUIAlertView:CONFIRM_TITLE
    message:message
                   name:CONFIRM_BUTTON_NAME];
    
}

/**
 *头部状态栏颜色设置
 */
+(void)navigationHeader:(UINavigationController *)navigationController{
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [navigationController.navigationBar setBackgroundColor
     :[UIColor redColor]];
}

/**
 *头部图像设置，需手工添加到具体页面
 */
+(UIImageView *)navigationHeaderWithImage:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                                                                          NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    NSString *image =imageName;
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}

/**
 *头部图像设置，需提供调用也的View
 */
+(void)navigationHeaderWithImage:(NSString *)imageName view:(UIView *)view
{
    NSString *defaultImage=NAVIGATION_IMAGE;
    if (imageName!=nil) {
        defaultImage=imageName;
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
         NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    NSString *image =defaultImage;
    imageView.image = [UIImage imageNamed:image];
    [view addSubview:imageView];
}

/**
 *主题颜色
 */
+(UIColor *)navigationColor{
    return [[UIColor alloc] initWithRed:0.45 green:0 blue:0 alpha:1];
}

+(UIColor *)tintyColor{
    return [UIColor whiteColor];
}

/**
 *
 */
+(UIColor *)backgroundColor{
    return  [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
}

+(void )initNavigationHeaderWithDefault:(UIViewController *)viewController
                      navigationProcess:(id<NavigationProcess>) navigationProcess
                                  title:(NSString *)title{
    
    UINavigationItem *navigationItem=viewController.navigationItem;
    
    [navigationItem setTitle:title];
    
    UINavigationBar *bar = viewController.navigationController.navigationBar;
    
    [bar setTintColor:[UIColor whiteColor ]];
    //BSUIBlockButton *backButton = [BSUIComponentView backNavButton:navigationProcess title:title image:nil];
    /*
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"<返回"
                                  style:UIBarButtonItemStyleDone
                                  target:viewController
                                 action:@selector(backClick)];
    //导航栏左侧按钮
    myButton.image= [UIImage imageNamed:@"im_return"];
    navigationItem.leftBarButtonItem = myButton;
    */
    
   
}

/**
 *带有表头，以普通View代替系统提供的导航栏
 */
+(void)initNarHeaderWithDefault:(BSUICommonController *)currentController
                          title:(NSString *)title //定义块类型
    {
    
    UIView *headerView=[BSUIComponentView headerView];
        
    BSUIBlockButton *backButton = [BSUIComponentView backNavButton:currentController target:currentController
        title:title image:nil];

        
    [headerView addSubview:backButton];
    
    UILabel *headNameLabel=[BSUIComponentView labelNav:title];
    
   
    [headerView addSubview:headNameLabel];

        
   BSUIBlockButton *okButton =[BSUIComponentView okNavButton:currentController target:currentController
         title:title image:nil];
    
        [headerView addSubview:okButton];
       
        [headerView setBackgroundColor:[BSUIComponentView navigationColor] ];
        
    [currentController.view addSubview:headerView];
}


//NS_ENUM_DEPRECATED_IOS(2_0, 8_0, "Use UIBarButtonItemStylePlain when minimum deployment target is iOS7 or later
/**
 *状态栏，默认使用,没有状态栏，使用Button制作。
 */

+(void)initNarHeaderWithIndexView:(UIViewController *)currentController
                            title:(NSString *)title //定义块类型
{
    BSUIBlockButton *okButton =[BSUIComponentView okNavButton:currentController target:currentController
                                                        title:title image:nil];
    
    [currentController.view addSubview:okButton];
}
/*
+(void)initNarHeaderWithIndexView:(UIViewController *)currentController
                          title:(NSString *)title //定义块类型
{

    @try {
        UIToolbar *mycustomToolBar;
        NSMutableArray *mycustomButtons = [[NSMutableArray alloc] init];
        UIBarButtonItem *myButton1 = [BSUIComponentView backBarButtonItem:currentController target:currentController title:title image:nil];
        
        myButton1.width = 40;
        [mycustomButtons addObject: myButton1];
        UIBarButtonItem *myButton2 = [BSUIComponentView okBarButtonItem:currentController target:currentController title:title image:nil];
        
        myButton2.width = 40;
        [mycustomButtons addObject: myButton2];
        
        mycustomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,320.0f, 44.0f)];
       // mycustomToolBar.center = CGPointMake(160.0f,200.0f);
        mycustomToolBar.barStyle = UIBarStyleDefault;
        [mycustomToolBar setItems:mycustomButtons animated:YES];
        [mycustomToolBar sizeToFit];
        [currentController.view addSubview:mycustomToolBar];
        currentController.navigationItem.titleView = mycustomToolBar;
        }
    @catch (NSException *exception) {
        NSLog(@"状态栏错误");
    }
 }
*/
#pragma mark -表头导航按钮的私有方法定义
/**
 *私有方法
 *统一的头部返回按钮
 */
+(BSUIBlockButton *)backNavButton:(id<NavigationProcess>) navigationProcess
                            target:(UIViewController *)target
                            title:(NSString *)title image:(NSString *)image{
    BSUIBlockButton *backButton = [[BSUIBlockButton alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.05,
                                                                                   NAVIGATIONBAR_Y+STATUS_HEIGHT,NAVIGATIONBAR_HEIGHT/3, NAVIGATIONBAR_HEIGHT/3)
                                   target:target
                                                                 action:@selector(backClick)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"]
                          forState:UIControlStateNormal];
    [backButton setBlock:^(BSUIBlockButton *button){
        [navigationProcess backClick];
    }];
    
    //[backButton setBackgroundColor:[UIColor whiteColor]];
    [backButton setTintColor:[UIColor whiteColor]];
    
    return backButton;
    
}


/**
 *私有方法
 *头部导航的确定按钮
 */
+(BSUIBlockButton *)okNavButton:(id<NavigationProcess>) navigationProcess
                            target:(UIViewController *)target
                          title:(NSString *)title image:(NSString *)image {
    BSUIBlockButton *okButton = [[BSUIBlockButton alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.72,
                                                                                 NAVIGATIONBAR_Y+STATUS_HEIGHT+10,NAVIGATIONBAR_HEIGHT/3, NAVIGATIONBAR_HEIGHT/3)
                                 target:target
                                 action:@selector(doneClick)];
    [okButton setBackgroundImage:[UIImage imageNamed:@"im_search"]
                        forState:UIControlStateNormal];
    [okButton setBlock:^(BSUIBlockButton *button){
        [navigationProcess backClick];
    }];
    [okButton setBackgroundColor:[UIColor grayColor]];
    [okButton setTintColor:[UIColor whiteColor]];
    return okButton;
    
}

+(BSUIBarButtonItem *)okBarButtonItem:(id<NavigationProcess>) navigationProcess  target:(UIViewController *)target title:(NSString *)title image:(NSString *)image{
    BSUIBarButtonItem *okButtonItem = [[BSUIBarButtonItem alloc]
                                  initWithTitle:title
                                  target:target
                                       action:@selector(doneClick)];
 
    return okButtonItem;
}

+(BSUIBarButtonItem *)backBarButtonItem:(id<NavigationProcess>) navigationProcess target:(UIViewController *)target title:(NSString *)title image:(NSString *)image{
    BSUIBarButtonItem *backButtonItem = [[BSUIBarButtonItem alloc]
                                       initWithTitle:title
                                         target:target
                                         action:@selector(backClick)
];
   
    return backButtonItem;
}


/*
 *私有方法
 *头部的导航条标签
 */
+(UILabel *)labelNav:(NSString *)title{
    UILabel *headNameLabel=[[UILabel alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.33, 10,NAVIGATIONBAR_WIDTH/3, NAVIGATIONBAR_HEIGHT)];
    if (title) {
        [headNameLabel setText:title];
    }else{
        [headNameLabel setText:[Conf appInfo]];
    }
    //[headNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [headNameLabel setTextAlignment: NSTextAlignmentCenter];
    [headNameLabel setTextColor:[UIColor whiteColor]];
    
    return headNameLabel;
}

/*
 *私有方法
 *统一的头部UIView
 */
+(UIView *)headerView{
    UIView *headerView=[[UIView alloc] initWithFrame:BSRectMake( NAVIGATIONBAR_X+SCREEN_WIDTH*0.6, NAVIGATIONBAR_Y,100, NAVIGATIONBAR_HEIGHT)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:0.79 green:0.12 blue:0 alpha:0.90]];
    
    return headerView;
}

/**
 *默认TabBar初始化方法
 */
+(void)initTabBarWithDefault:(UITabBarController *)tabBarController{
    //设置tabBar的选中颜色
    tabBarController.tabBar.tintColor=[BSUIComponentView  navigationColor];
    //修改more的风格
    tabBarController.moreNavigationController.navigationBar.barStyle=UIBarStyleBlack;
    tabBarController.moreNavigationController.navigationBar.backgroundColor=[BSUIComponentView  navigationColor];
    rootTabBarController=tabBarController;
}

+(void)changeTabBarWithNotification:(UIViewController *)uiViewController addedInfo:(NSString *)info{
    UITabBar *bar=rootTabBarController.tabBar;
    UIBarItem *item=bar.items[0];
    if (info) {
        NSString *name=[[NSString stringWithString:item.title]stringByAppendingString:info];
        [BSUIComponentView changeTabMoreWithTitle:name withVC:uiViewController];
    }

}


+(void)changeTabMoreWithTitle:(NSString*) title withVC:(UIViewController*)vc{
    if(vc.tabBarController){
        if(vc.tabBarController.moreNavigationController){
            UITabBar *tb = vc.tabBarController.moreNavigationController.tabBarController.tabBar;
            UIView *tbb=[[tb subviews] lastObject];
            
            UIView *v=[[tbb subviews]lastObject];
        }else{
            NSLog(@"传入的UIViewController 必须含有tabBarController与moreNavigationController");
        }
    }else{
        NSLog(@"传入的UIViewController 必须含有tabBarController与moreNavigationController");
    }
}

@end
