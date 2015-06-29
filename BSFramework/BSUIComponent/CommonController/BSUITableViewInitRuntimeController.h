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
 *获取章节的头信息
 */
-(NSString *)titleForHeaderInSection:(NSInteger)section;

/**
 *当前章节的数量
 */
-(NSInteger)currentSectionNumber;

/**
 *当前章节行数
 */
-(NSInteger) rowSectionNumber:(NSInteger)section;

/**
 *当前行的数据信息
 */
-(NSObject *) bsContentObject:(NSInteger)section row:(NSInteger)row;

/**
 *暂时没有使用
 */
-(NSMutableArray *)indexes;

@end
