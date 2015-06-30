//
//  TableViewCellData.h
//  KTAPP
//  根据表格定义,处理单表格
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BSTableContentObject.h"
#import "BSTableSection.h"

@interface BSTableViewCellData : NSObject

@property (strong,nonatomic)BSTableSection *bSTableObjects;
@property (strong,nonatomic)UITableView *tableView;
/**
 *根据表格章节获取表格数据处理实例
 */
+(instancetype)initWithTableSelection:(BSTableSection *)bsTableSection tableView:(UITableView *)table;

#pragma mark -表格绘制实现方法
/**
 *对TableViewController的接口方法
 *公共方法，绘制单元格
 *按照表格中规定的显示表格信息
 */
-(UITableViewCell *)processTableViewCell:(NSInteger)section row:(NSInteger)row;

#pragma mark -表格绘制方法
/**
 *显示单元格
 *公共方法，需要继承或单独实现，来完成单元格绘制
 */
-(UITableViewCell *)processTableViewCell:(Class) cellClass
                         bsContentObject:(BSTableContentObject *)bsContentObject;

/**
 *手工处理时，由于没有NIB的绑定，需要手工添加到视图中
 *目前默认标示为Section提供的，而且是一个章节，在多章节之后，这里的判断要么来自具体的章节，要么来自BSContentObject
 */
-(UITableViewCell *)handProcessTableViewCell:(Class) cellClass
                             bsContentObject:(BSTableContentObject *)bsContentObject;

/**
 *TableViewCell处理私有方法 根据配置获得UI的实现
 *如果出现异常，则处理异常返回nil
 */
-(id)uiTableViewCellWithIdentifier:(NSString*)identifer;

/**
 *根据章节索引获取章节标题
 */
-(NSString *)titleForHeaderInSection:(NSInteger)section;

/**
 *根据章节和每个章节的数据数目获取行信息
 */
-(NSObject *)currentContentObject:(NSInteger)section row:(NSInteger)row;

-(NSString *)storyboardName;

@end
