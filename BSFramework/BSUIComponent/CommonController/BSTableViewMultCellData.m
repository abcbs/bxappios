//
//  BSTableViewMultCellData.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableViewMultCellData.h"

@implementation BSTableViewMultCellData


/**
 *根据章节和每个章节的数据数目获取行信息
 */
-(NSObject *)currentContentObject:(NSInteger)section row:(NSInteger)row{
    NSMutableArray *bsArray=[NSMutableArray arrayWithCapacity:[self.bSTableObjects currentCapatibilty:section]];
    BSTableContentObject * bc= ((BSTableContentObject *)[self.bSTableObjects currentContentObject:section row:row]);
    bc.colCapatibilty=self.bSTableObjects.colCapatibilty;
    bc.callerViewController=self.controller;
    
    [bsArray addObject:bc];
    bc= ((BSTableContentObject *)[self.bSTableObjects currentContentObject:section row:row+1]);
    bc.colCapatibilty=self.bSTableObjects.colCapatibilty;
    bc.storybordName=self.bSTableObjects.storyboardName;
    bc.callerViewController=self.controller;
    [bsArray addObject:bc];
   return bsArray;
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



@end
