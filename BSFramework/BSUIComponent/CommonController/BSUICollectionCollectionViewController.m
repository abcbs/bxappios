//
//  BSUICollectionCollectionViewController.m
//  KTAPP
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICollectionCollectionViewController.h"
#import "BSUIFrameworkHeader.h"
#import "UserManager.h"

@interface BSUICollectionCollectionViewController ()

@end

@implementation BSUICollectionCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];

        [BSUIComponentView initNarHeaderWithDefault:self
                                              title:self.title
                            bDisplaySearchButtonNav:self.bDisplaySearchButtonNav
                            bDisplayReturnButtonNav:self.bDisplayReturnButtonNav
         
         ];
        [BSUIComponentView navigationHeader:self.navigationController];
        
    }else{
        
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self  title: self.title];
        
    }
    
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    
    [self modifiedStyle];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    BSLog(@"BSUICollectionCollectionViewController viewDidAppear,%@",self.description);
    
}
#pragma mark --默认处理方法
-(void)modifiedStyle{
    BSLog(@"根据权限修改元素显示，子类需实现");
}
#pragma mark --默认返回方法，仅仅在人工提供的状态栏中使用
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --默认统一处理方法，使用表格查询方式
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
}

#pragma mark --轮播事件响应 有轮播图，需要点击轮播图处理信息
- (void)touchAction:(UIGestureRecognizer *)gester{
    BSLog(@"子类应当继承此方法实现完成轮播功能功能");
}

#pragma mark --控制是否可以根据故事板跳转
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if(self.bsContentObject.noNeedLoginCheck){
        return YES;
    }
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {
        [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController" canUseStoryboard:YES];
        
    }
    return isLogin;
}

#pragma mark --登陆工具方法
-(BOOL)checkAndLogin{
    if(self.bsContentObject.noNeedLoginCheck){
        return YES;
    }
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {
        [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController" canUseStoryboard:YES];
        
    }
    return isLogin;
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];
}

#pragma mark --功能装配控制器的跳转方法
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    bsContentObject.noNeedLoginCheck=check;
    [self navigating:bsContentObject];
}
@end
