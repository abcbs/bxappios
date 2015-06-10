//
//  MyOrderCell.h
//  民生小区
//
//  Created by 闫青青 on 15/5/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderModel;
@interface MyOrderCell : UITableViewCell
//配置cell
- (void)configOrderModelWith:(MyOrderModel *)OrderModel;
@end
