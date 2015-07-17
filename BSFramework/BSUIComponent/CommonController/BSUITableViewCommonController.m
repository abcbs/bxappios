//
//  BSUITableViewCommonController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"

@implementation BSUITableViewCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
    navigationProcess:self
                                                     title:self.title];
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];
        [BSUIComponentView navigationHeader:self.navigationController];
        
    }else{

        //没有导航栏，使用Button完成
        [BSUIComponentView initTableNarHeaderWithDefault:self tableView:self.tableView  title: self.title];
        
    }
  
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"BSUICommonController viewDidAppear,%@",self.description);

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        NSLog(@"init initWithCoder%@",self.description);
    }
    return self;
}
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
}

-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];
}
/**
 *页面跳转公共方法
 */
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}
- (UITableViewCell *)obtainCellWith:(NSString *)identifer{
        UITableViewCell *cell=nil;
        cell=[self.tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        }
    return cell;
}

@end
