//
//  BSUIComponentView.m
//  KTAPP
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIComponentView.h"
#import "BSUIFrameworkHeader.h"


#define CONFIRM_TITLE @"错误提示"
#define CONFIRM_BUTTON_NAME @"确定"

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

+(void)navigationHeader:(UINavigationController *)navigationController{
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [navigationController.navigationBar setBackgroundColor
     :[UIColor redColor]];
}

+(UIImageView *)navigationHeaderWithImage:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                                                                          NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    NSString *image =imageName;
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}


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


+(UIColor *)navigationColor{
    return [UIColor redColor];
}

+(UIColor *)backgroundColor{
    return  [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
}

+(void)initNarHeaderWithDefault:(UIViewController *)currentController
                          title:(NSString *)title //定义块类型
    {
    
    UIView *headerView=[[UIView alloc] initWithFrame:BSRectMake( NAVIGATIONBAR_X, NAVIGATIONBAR_Y,NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
        
    [headerView setBackgroundColor:[UIColor colorWithRed:0.79 green:0.12 blue:0 alpha:0.90]];
    
    BSUIBlockButton *backButton = [[BSUIBlockButton alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.05,
        NAVIGATIONBAR_Y+STATUS_HEIGHT,NAVIGATIONBAR_HEIGHT/3, NAVIGATIONBAR_HEIGHT/3)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"]
                          forState:UIControlStateNormal];
    [backButton setBlock:^(BSUIBlockButton *button){
        [currentController dismissViewControllerAnimated:YES completion:nil];
    }];
   
    //[backButton setBackgroundColor:[UIColor whiteColor]];
    [backButton setTintColor:[UIColor whiteColor]];
    [headerView addSubview:backButton];
    
    UILabel *headNameLabel=[[UILabel alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.3, NAVIGATIONBAR_Y,NAVIGATIONBAR_WIDTH/3, NAVIGATIONBAR_HEIGHT)];
    if (title) {
        [headNameLabel setText:title];
    }else{
        [headNameLabel setText:[Conf appInfo]];
    }
    [headNameLabel setText:[Conf appInfo]];
    [headNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [headNameLabel setTextAlignment: NSTextAlignmentCenter];
    [headNameLabel setTextColor:[UIColor whiteColor]];
   
    [headerView addSubview:headNameLabel];

        
        
  BSUIBlockButton *okButton = [[BSUIBlockButton alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.8, NAVIGATIONBAR_Y+STATUS_HEIGHT,NAVIGATIONBAR_HEIGHT/3, NAVIGATIONBAR_HEIGHT/3)];
 
        
    [okButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"]
                              forState:UIControlStateNormal];
    [okButton setBlock:^(BSUIBlockButton *button){
            id<NavigationProcess> cc=currentController;
            [cc doneClick];
        }];

    [okButton setTintColor:[UIColor whiteColor]];
      


    [headerView addSubview:okButton];
        
    [currentController.view addSubview:headerView];
    
    
}

+(void)initNarHeaderWithIndexView:(UIViewController *)currentController
                          title:(NSString *)title //定义块类型
{
    
    UIView *headerView=[[UIView alloc] initWithFrame:BSRectMake( NAVIGATIONBAR_X, NAVIGATIONBAR_Y,NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT)];
    //[headerView setBackgroundColor:[UIColor darkTextColor]];
    
    UILabel *headNameLabel=[[UILabel alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X+NAVIGATIONBAR_WIDTH*0.3, NAVIGATIONBAR_Y,NAVIGATIONBAR_WIDTH/3, NAVIGATIONBAR_HEIGHT)];
    if (title) {
        [headNameLabel setText:title];
    }else{
        [headNameLabel setText:[Conf appInfo]];
    }
    [headNameLabel setText:[Conf appInfo]];
    [headNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [headNameLabel setTextAlignment: NSTextAlignmentCenter];
    //[headNameLabel setTextColor:[UIColor whiteColor]];
    
    [headerView addSubview:headNameLabel];
    
    [currentController.view addSubview:headerView];
    
}

@end
