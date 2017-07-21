//
//  MSWaterSendingCell.h
//  民生小区
//
//  Created by Milo. on 15-4-15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterSending;

@interface MSWaterSendingCell : UITableViewCell

@property (nonatomic, strong) WaterSending *model;



+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
