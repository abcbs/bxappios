//
//  BSCommonTabBarController.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUITabBarCommonController.h"
#import "BSCMFrameworkHeader.h"
#import "UserManager.h"

@interface BSUITabBarCommonController ()

@end

@implementation BSUITabBarCommonController



- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //id<UITabBarControllerDelegate> tabBardDelegate=self;
    //self.delegate = tabBardDelegate ;
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        /*
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                        navigationProcess:self
                                                     title:self.title];
        */
    }else{
        //没有导航栏，使用Button完成
        //[BSUIComponentView initNarHeaderWithIndexView:self
        //                                        title:self.title];
        
    }
    //设置导航栏颜色
    [BSUIComponentView navigationHeader:self.navigationController];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    BSLog(@"viewDidAppear\t%@",self.description);
    
}

#pragma mark --公共返回事件响应
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --公共确定功能，目前绑定为查询功能图标
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
}

#pragma mark --轮播事件响应 有轮播图，需要点击轮播图处理信息
- (void)touchAction:(UIGestureRecognizer *)gester{
    BSLog(@"子类应当继承此方法实现完成轮播功能功能");
}

-(void)modifiedStyle{
    BSLog(@"根据权限修改元素显示，子类需实现");
    [BSUIComponentView initNavigationWithPermission:self];
}

#pragma mark --登陆工具方法
-(BOOL)checkAndLogin{
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {
        [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController" canUseStoryboard:YES];
        
    }
    return isLogin;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
