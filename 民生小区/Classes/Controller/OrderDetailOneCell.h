//
//  OrderDetailOneCell.h
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class orderDetailOneModel;
@interface OrderDetailOneCell : UITableViewCell
//配置cell
- (void)configOrderDetailOneModelWith:(orderDetailOneModel*)orderDetailOneModel;
@end
