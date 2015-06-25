//
//  BSUITableViewInitRuntimeController.h
//  KTAPP
//  实现表格视图的章节、行数据绑定，当点击行时，进入相关子界面
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTableSection.h"


@interface BSUITableViewInitRuntimeController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) BSTableSection *bSTableObjects;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(NSString *)titleForHeaderInSection:(NSInteger)section;

-(NSInteger)currentSectionNumber;

-(NSInteger) rowSectionNumber:(NSInteger)section;

-(BSTableContentObject *) bsContentObject:(NSInteger)section row:(NSInteger)row;

-(NSMutableArray *)indexes;

@end
