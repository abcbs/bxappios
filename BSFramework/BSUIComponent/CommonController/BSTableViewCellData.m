//
//  TableViewCellData.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSTableViewCellData.h"
#import <UIKit/UIKit.h>
#import "BSTableContentObject.h"
#import "BSTableSection.h"
#import "BSUIFrameworkHeader.h"

@implementation BSTableViewCellData

@synthesize bSTableObjects;
@synthesize tableView;
@synthesize controller;

+(instancetype)initWithTableSelection:(UIViewController *)viewController bsTableSection:(BSTableSection *)bsTableSection tableView:(UITableView *)table{
    id bs=[[super alloc]initWithTableSelection:viewController bsTableSection:bsTableSection tableView:table];
    return bs;
}

-(instancetype)initWithTableSelection:(UIViewController *)viewController bsTableSection:(BSTableSection *)bsTableSection tableView:(UITableView *)table{
    self.bSTableObjects=bsTableSection;
    self.tableView=table;
    self.controller=viewController;
    return self;
}

/**
 *对应在TableViewController调用方法
 */
-(UITableViewCell *)processTableViewCell:(NSInteger)section row:(NSInteger)row
{
    NSString *ID = [self currentCellIdentifierWithSection:section];
    UITableViewCell *cell=[self uiTableViewCellWithIdentifier:ID];
    if (cell==nil) {
        UINib *nib = [UINib nibWithNibName:ID bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:ID];
        
    }
    Class clzz=[self cellIdentifierWithSection:section];
    id bsContentObject=(BSTableContentObject *)[self currentContentObject:section row:row];
    return [self processTableViewCell:clzz bsContentObject:bsContentObject];
    
}

#pragma mark 实现方法
/**
 *私有 适配方法 根据章节获取每个章节的TellerViewCell
 */
-(NSString *)currentCellIdentifierWithSection:(NSInteger)section{
    return [self.bSTableObjects cellIdentifier];
}


/**
 *显示单元格，需根据表格为数组方式重载
 *公共方法，
 */
-(UITableViewCell *)processTableViewCell:(Class) cellClass
                         bsContentObject:(BSTableContentObject *)bsContentObject{
    NSString *Identifier = [self.bSTableObjects cellIdentifier];
    
    id cell=[self uiTableViewCellWithIdentifier:Identifier];
    if (cell==nil) {//没有在NIB或者故事板中定义
        return [self handProcessTableViewCell:cellClass
                              bsContentObject:bsContentObject];
    }
    //不是手工编码根据配置的方法执行具体的方法
    //if (bsContentObject.method) {
    //    [cell setValue:bsContentObject.method forKeyPath:@"method"];
    //}
    //不是手工处理直接调用TableViewCell的方法viewCellWithBSContentObject
    return [self autoProcessTableViewCell:cell bsContentObject:bsContentObject];
    
}

/**
 *公有方法，需要在实现表格为数组数据时继承
 *NIB或故事板自动完成表格需要继承或单独实现，来完成单元格绘制
 */
-(UITableViewCell *)autoProcessTableViewCell:(id)cell bsContentObject:(BSTableContentObject *)bsContentObject{
    return [cell viewCellWithBSContentObject:bsContentObject];
}
/**
 *手工处理时，由于没有NIB的绑定，需要手工添加到视图中
 *目前默认标示为Section提供的，而且是一个章节，在多章节之后，这里的判断要么来自具体的章节，要么来自BSContentObject
 */
-(UITableViewCell *)handProcessTableViewCell:(Class) cellClass
                             bsContentObject:(BSTableContentObject *)bsContentObject{
    id cell=[[cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:[self.bSTableObjects cellIdentifier]];
    if (bsContentObject.method) {
        [cell setValue:bsContentObject.method forKeyPath:@"method"];
    }
    return [cell viewCellWithHandBSContentObject:bsContentObject];
    
}

/**
 *TableViewCell处理私有方法 根据配置获得UI的实现
 *如果出现异常，则处理异常返回nil
 */
-(id)uiTableViewCellWithIdentifier:(NSString*)identifer
{
    @try {
        return
        [self.tableView dequeueReusableCellWithIdentifier:identifer];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        BSLog(@"获取TableViewCell");
    }
    
}

/**
 *根据章节和每个章节的数据数目获取行信息
 */

-(NSObject *)currentContentObject:(NSInteger)section row:(NSInteger)row{
    return ((BSTableContentObject *)[self.bSTableObjects currentContentObject:section row:row]);
}

/**
 *私有方法，根据章节获得它的cell标示
 */

-(Class) cellIdentifierWithSection:(NSInteger)section{
    return [self.bSTableObjects cellClass];
}

/**
 *根据章节索引获取章节标题
 */

-(NSString *)titleForHeaderInSection:(NSInteger)section{
    return [self.bSTableObjects.content objectAtIndex:section];
}


/**
 *故事板名称,目前方法只是取得BSTableSection中的配置
 */

-(NSString *)storyboardName{
    return self.bSTableObjects.storyboardName;
}

@end
