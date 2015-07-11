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
        
    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self title: self.title];
        
    }
    [BSUIComponentView navigationHeader:self.navigationController];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"BSUICommonController viewDidAppear,%@",self.description);

}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"子类应当继承此方法实现完成功能");
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
