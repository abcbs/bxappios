//
//  BSCommonTabBarController.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITabBarCommonController.h"

@interface BSUITabBarCommonController ()

@end

@implementation BSUITabBarCommonController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BSUIComponentView initNavigationHeaderWithDefault:self
                                     navigationProcess:self title:nil
     ];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"BSUITabBarCommonController viewDidAppear 对象的视图已经加入到窗口时调用");
    
}
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
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

@end
