//
//  BSUICommonController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"
#import "UserManager.h"
@implementation BSUICommonController


- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"BSUICommonController viewDidLoad %@",self.description);
     if (self.navigationController) {
         [BSUIComponentView initNarHeaderWithDefault:self
                                               title:self.title
                             bDisplaySearchButtonNav:self.bDisplaySearchButtonNav
                             bDisplayReturnButtonNav:self.bDisplayReturnButtonNav
          
          ];
         
    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self title: self.title];

    }
    //设置导航栏颜色
    [BSUIComponentView navigationHeader:self.navigationController];
    //设置Tab栏
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];

    [self modifiedStyle];
}


- (void)viewDidAppear:(BOOL)animated{

    BSLog(@"viewDidAppear 对象的视图已经加入到窗口时调用,%@",self.description);
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [BSUIComponentView initNavigationWithPermission:self];
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];

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
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];

    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewWillDisappear,%@",self.description);
    [super viewWillDisappear:animated];

}

- (void)dealloc{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)initSubViews
{
    //修改样式
    //登陆按钮
   
    
}

-(void)delelageForTextField{
   
    
    
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
#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    bsContentObject.noNeedLoginCheck=check;
    [self navigating:bsContentObject];
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

@end
