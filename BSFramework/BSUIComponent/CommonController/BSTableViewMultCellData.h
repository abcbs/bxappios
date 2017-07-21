//
//  BSTableViewMultCellData.h
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSTableViewCellData.h"
#import "BSUIFrameworkHeader.h"

@interface BSTableViewMultCellData : BSTableViewCellData

/**
 *多列和单列不同在于多列数据返回为BSTableContentObject的数组，此数组由具体的
 *TableViewCell处理
 */
-(NSObject *)currentContentObject:(NSInteger)section row:(NSInteger)row;

/**
 *公有方法，需要继承
 *手工处理时，由于没有NIB的绑定，需要手工添加到视图中
 *目前默认标示为Section提供的，而且是一个章节，在多章节之后，这里的判断要么来自具体的章节，要么来自BSContentObject
 */
-(UITableViewCell *)handProcessTableViewCell:(Class) cellClass
                             bsContentObject:(BSTableContentObject *)bsContentObject;

/**
 *公有方法，需要在实现表格为数组数据时继承
 *NIB或故事板自动完成表格需要继承或单独实现，来完成单元格绘制
 */
-(UITableViewCell *)autoProcessTableViewCell:(id)cell bsContentObject:(BSTableContentObject *)bsContentObject;


@end
