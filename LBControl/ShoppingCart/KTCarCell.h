//
//  KTCarCell.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterSending.h"
@class WaterSending;
@class CartList;

@interface KTCarCell : UITableViewCell

@property (nonatomic, assign)BOOL isSelect;
@property (copy, nonatomic, readwrite) void (^applyCallBack)(NSInteger tag,BOOL isSelected);
@property (copy, nonatomic, readwrite) void (^plusOrMinCallBack)(NSInteger tag);
@property (nonatomic, strong) WaterSending *waterSending;

@property (nonatomic, strong) CartList *carlist;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *productSalePrice;
@property (weak, nonatomic) IBOutlet UILabel *productPreferPrice;
@property (weak, nonatomic) IBOutlet UIButton *count;

@end
