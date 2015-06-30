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
    return ((BSTableContentObject *)[self.bSTableObjects currentContentObject:section row:row]);
}

@end
