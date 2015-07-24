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

@implementation BSUICommonController


- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"BSUICommonController viewDidLoad %@",self.description);
     if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];

    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self title: self.title];

    }
    //设置导航栏颜色
    [BSUIComponentView navigationHeader:self.navigationController];
    //设置Tab栏
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];
}


- (void)viewDidAppear:(BOOL)animated{

    BSLog(@"viewDidAppear 对象的视图已经加入到窗口时调用,%@",self.description);
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

- (void)backClick{
  [self dismissViewControllerAnimated:YES completion:nil];
  
}
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
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
