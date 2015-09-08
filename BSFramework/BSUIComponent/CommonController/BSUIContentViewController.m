//
//  BSUIContentViewController.m
//  KTAPP
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIContentViewController.h"
#import "UserManager.h"
@interface BSUIContentViewController ()

@end

@implementation BSUIContentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BSUICommonController viewDidLoad %@",self.description);
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNarHeaderWithDefault:self
                                              title:self.title
                            bDisplaySearchButtonNav:self.bDisplaySearchButtonNav
                            bDisplayReturnButtonNav:self.bDisplayReturnButtonNav
         
         ];
    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initContentNarHeaderWithDefault:self target:self title: self.title];
        
    }
    //设置Tab栏
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [self modifiedStyle];
}


- (void)viewDidAppear:(BOOL)animated{
    
    BSLog(@"viewDidAppear 对象的视图已经加入到窗口时调用,%@",self.description);
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [BSUIComponentView initNavigationWithPermission:self];
    [self modifiedStyle];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        BSLog(@"init initWithCoder%@",self.description);
    }
    return self;
}


-(void) viewDidDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewDidDisappear,%@",self.description);
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewWillDisappear,%@",self.description);
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    
}

-(void)modifiedStyle{
    BSLog(@"根据权限修改元素显示，子类需实现");
   
}

/**
 *公共返回按钮
 */
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *公共确定按钮
 */
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
}

/**
 *轮播事件响应 有轮播图，需要点击轮播图处理信息
 */
- (void)touchAction:(UIGestureRecognizer *)gester{
    BSLog(@"子类应当继承此方法实现完成轮播功能功能");
}

//控制是否可以根据故事板跳转
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

/**
 *页面跳转公共方法
 */
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}

-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];
    
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    bsContentObject.noNeedLoginCheck=check;
    [self navigating:bsContentObject];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end
