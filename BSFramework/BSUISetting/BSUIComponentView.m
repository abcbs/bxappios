//
//  BSUIComponentView.m
//  KTAPP
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUIComponentView.h"
#import "BSUIFrameworkHeader.h"
#import "BSUIBlockButton.h"
#import "BSUIBarButtonItem.h"

#define CONFIRM_TITLE @"错误提示"
#define CONFIRM_BUTTON_NAME @"确定"

UITabBarController * rootTabBarController;

@interface BSUIComponentView (){
    //NSArray *tabBarItemArray;
}

@property (strong,nonatomic) UIViewController *rootUIViewController;

@end

@implementation BSUIComponentView

static  NSArray *tabBarItemArray;

static  UITabBar  *gTabBar;


+(UITabBar *)displayGlobleTabBar{
    if (gTabBar) {
        gTabBar.hidden=NO;

    }
    return gTabBar;
}

+(void )initGobleTabBar:(UITabBar *)tabBar{
    if (gTabBar==nil) {
         gTabBar=tabBar;
    }
}
+(NSArray *)globleTabBarItemArray{
    return tabBarItemArray;
}
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

+ (void)autoSytleLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = BSRectMake(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = BSRectMake(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
        }
    }
}


/**
 *头部状态栏颜色设置
 *配置浏览栏颜色
 */
+(void)navigationHeader:(UINavigationController *)navigationController{
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [navigationController.navigationBar setBackgroundColor
     :[UIColor redColor]];
}

/**
 *头部图像设置，需手工添加到具体页面,无使用
 */
+(UIImageView *)navigationHeaderWithImage:(NSString *)imageName
BSDeprecated("建议使用统一处理方式，使用initNavigationHeaderWithDefault"){
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                                                                          NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    NSString *image =imageName;
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}

/**
 *头部图像设置，需提供调用也的View
 *communicate
 *SetViewController
 */
+(void)navigationHeaderWithImage:(NSString *)imageName view:(UIView *)view
       BSDeprecated("建议使用统一处理方式，使用initNavigationHeaderWithDefault")
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
 *设置Button的样式
 */
+(void)configButtonStyle:(UIButton *)button{
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [button.layer setBorderWidth:1.0]; //边框宽度
    
    [button setBackgroundColor:[BSUIComponentView navigationColor]];
      
    [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
}
+(void)configLableStyle:(UILabel *)lable{
    [lable.layer setMasksToBounds:YES];
    [lable.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [lable.layer setBorderWidth:1.0]; //边框宽度
    [lable setBackgroundColor:[BSUIComponentView navigationColor]];

}
/**
 *
 *UIImage样式
 */
+(void)configImageStyle:(UIView *)image{
    [image.layer setMasksToBounds:YES];
    [image.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    //[image.layer setBorderWidth:1.0]; //边框宽度

}

/*
 *TextField样式
 */
+(void)configTextField:(UIView *)field{
    [field.layer setMasksToBounds:YES];
    [field.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    //[self.anonName.layer setBorderWidth:1.0]; //边框宽度
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
 *背景颜色
 */
+(UIColor *)backgroundColor{
    return  [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
}

/**
 *有系统导航栏
 *BSUICommonController
 *BSUITabBarCommonController
 *BSUITableViewCommonController
 */
+(void )initNavigationHeaderWithDefault:(UIViewController *)viewController
                      navigationProcess:(id<NavigationProcess>) navigationProcess
                                  title:(NSString *)title{
    
    UINavigationItem *navigationItem=viewController.navigationItem;
    
    [navigationItem setTitle:title];
    
    UINavigationBar *bar = viewController.navigationController.navigationBar;
    
    [bar setTintColor:[UIColor whiteColor ]];
    [BSUIComponentView navigationColor];

}


/**
 *私有方法，指定头的大小
 */
+(UIView *)headerViewNoNar{
    UIView *headerView=[[UIView alloc] initWithFrame:
            BSRectMake( NAVIGATIONBAR_X, NAVIGATIONBAR_Y,NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    
    //[headerView setBackgroundColor:[UIColor colorWithRed:0.79 green:0.12 blue:0 alpha:0.90]];
    
    return headerView;
}

/**
 *带有表头，以普通View代替系统提供的导航栏
 * BSUITableViewCommonController在使用
 */
+(void)initContentNarHeaderWithDefault:(UIViewController *)currentController
                                target:(id<NavigationProcess>)target

                          title:(NSString *)title //定义块类型
{
    
    UIView *headerView=[BSUIComponentView headerViewNoNar];

    
    BSUIBlockButton *backButton = [BSUIComponentView backNavButton:target target:currentController
     title:title image:nil];
     
     
     [headerView addSubview:backButton];
     
    UILabel *headNameLabel=[BSUIComponentView labelNav:title];
    
    
    [headerView addSubview:headNameLabel];
    
    
    BSUIBlockButton *okButton =[BSUIComponentView okNavButton:target target:currentController
                                                        title:title image:nil];
    
    [headerView addSubview:okButton];
    
    [headerView setBackgroundColor:[BSUIComponentView navigationColor] ];
    //tableView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 0.0f, 0.0f);
    [currentController.view addSubview:headerView];
}

+(void)initNarHeaderWithDefault:(UIViewController *)currentController
                          title:(NSString *)title
        bDisplaySearchButtonNav:(BOOL)searchItem
        bDisplayReturnButtonNav:(BOOL)returnItem{
    if (!searchItem&&!returnItem) {//有两类按钮
        [BSUIComponentView initNarHeaderWithDefault:currentController
                                              title:title];
    }else if (!searchItem&&returnItem){//有查询没有返回，左侧按钮删除
        currentController.navigationItem.leftBarButtonItem=nil;
        currentController.navigationItem.leftBarButtonItems=nil;
        [BSUIComponentView initNarHeaderWithDefault:currentController
                                              title:title];
    }else if(searchItem&&!returnItem){//无查询有返回，默认行为
        //
    }else if (searchItem&&returnItem){//无查询无返回
        //
        currentController.navigationItem.leftBarButtonItem=nil;
        currentController.navigationItem.leftBarButtonItems=nil;
    }
}

/**
 *带有表头，以普通View代替系统提供的导航栏
 *BSTableViewRefreshController,在使用
 */
+(void)initNarHeaderWithDefault:(BSUICommonController *)currentController
                          title:(NSString *)title //定义块类型
    {
    
        UINavigationItem *nav=currentController.navigationItem;
        UIBarButtonItem *rightButtton=nav.rightBarButtonItem;
        
        UIBarButtonItem *searchButtonItem=[BSUIComponentView okBarButtonItem:currentController  target:currentController title:title image:@"icon_search.png"];
        
        if (rightButtton) {
             NSMutableArray *arrays=[NSMutableArray array];
            [arrays addObject:rightButtton];
            [arrays addObject:searchButtonItem];
             currentController.navigationItem.rightBarButtonItems=arrays;
        }else{
            currentController.navigationItem.rightBarButtonItem=searchButtonItem;
        }
}


//NS_ENUM_DEPRECATED_IOS(2_0, 8_0, "Use UIBarButtonItemStylePlain when minimum deployment target is iOS7 or later
/**
 *状态栏，默认使用,没有状态栏，使用Button制作。
 *BSUITabBarCommonController
 */

+(void)initNarHeaderWithIndexView:(UIViewController *)currentController
                            title:(NSString *)title //定义块类型
{
    /*
    BSUIBlockButton *okButton =[BSUIComponentView okNavButton:currentController target:currentController
                                                        title:title image:nil];
    
    [currentController.view addSubview:okButton];
     */
}

/**
 *默认TabBar初始化方法
 *AppDelegate
 */
+(void)initTabBarWithDefault:(UITabBarController *)tabBarController{
    if( [tabBarController isKindOfClass:[UITabBarController class]]){
        //设置tabBar的选中颜色
        tabBarController.tabBar.tintColor=[BSUIComponentView  navigationColor];
        //修改more的风格
        tabBarController.moreNavigationController.navigationBar.barStyle=UIBarStyleBlack;
        tabBarController.moreNavigationController.navigationBar.backgroundColor=[BSUIComponentView  navigationColor];
        rootTabBarController=tabBarController;
    }
       
   }

+(void)changeTabBarWithNotification:(UIViewController *)uiViewController addedInfo:(NSString *)info{
    //uiViewController.tabBarItem.badgeValue=info;
    UITabBar *bar=rootTabBarController.tabBar;
    UITabBarItem *item=(UITabBarItem* )bar.selectedItem;
    item.badgeValue=info;
    //rootTabBarController.tabBarItem.badgeValue=@"10";
    tabBarItemArray=bar.items;
    if (info) {
        NSString *name=[[NSString stringWithString:item.title]stringByAppendingString:info];
        [BSUIComponentView changeTabMoreWithTitle:name withVC:uiViewController];
    }

    
}


+(void)changeTabMoreWithTitle:(NSString*) title withVC:(UIViewController*)vc{
    if(vc.tabBarController){
        if(vc.tabBarController.moreNavigationController){
            UITabBar *tb = vc.tabBarController.moreNavigationController.tabBarController.tabBar;
            UIBarItem *selectItem=tb.selectedItem;
            //tb.badgeValue=title;
            //selectItem.title  = title;
            selectItem.image = [UIImage imageNamed:@"second_normal"];
            //1.创建图片
            UIImage *selectmage = [UIImage imageNamed:@"second_selected"];
            //2. 告诉系统原样显示
            selectmage = [selectmage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
        }else{
            NSLog(@"传入的UIViewController 必须含有tabBarController与moreNavigationController");
        }
    }else{
        NSLog(@"传入的UIViewController 必须含有tabBarController与moreNavigationController");
    }
    
}

#pragma mark -表头导航按钮的私有方法定义
/**
 *私有方法
 *统一的头部返回按钮
 */
+(BSUIBlockButton *)backNavButton:(id<NavigationProcess>) navigationProcess
                            target:(UIViewController *)target
                            title:(NSString *)title image:(NSString *)image{
    BSUIBlockButton *backButton = [[BSUIBlockButton alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.05,
                                                                                   NAVIGATIONBAR_Y+10,NAVIGATIONBAR_HEIGHT, NAVIGATIONBAR_HEIGHT)
                                   target:target
                                                                 action:@selector(backClick)];
    //[backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"]
    //                      forState:UIControlStateNormal];
    [backButton setBlock:^(BSUIBlockButton *button){
        [navigationProcess backClick];
    }];
    
    NSString *name = [NSString stringWithFormat:@"返回"];
    
    
    [backButton setTintColor:[UIColor whiteColor]];
    [backButton setTitle:name forState:UIControlStateNormal];
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
    [okButton setBackgroundImage:[UIImage imageNamed:@"im_search.png"]
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
    okButtonItem.image=[UIImage imageNamed:image];
    okButtonItem.tintColor=[UIColor whiteColor];
   
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

+(void )initNavigationWithPermission:(UIViewController *)viewController{
    if (DEFAULT_ROLE) {
        viewController.navigationItem.rightBarButtonItem=nil;
        viewController.navigationItem.rightBarButtonItems=nil;
    }
}
@end
