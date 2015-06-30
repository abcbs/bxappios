//
//  BSUITableViewInitRuntimeController.h
//  KTAPP
//  实现表格视图的章节、行数据绑定，当点击行时，进入相关子界面
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"


@interface BSUITableViewInitRuntimeController :
    BSUICommonController<UITableViewDataSource,UITableViewDelegate,NavigationProcess>

@property (retain, nonatomic) BSTableSection *bSTableObjects;


@property (strong, nonatomic) IBOutlet UITableView *tableView;


/**
 *设置分割线风格，默认为没有分割线
 */
-(void)setSeparatorStyle:(UITableViewCellSeparatorStyle *)separatorStyle;



@end
