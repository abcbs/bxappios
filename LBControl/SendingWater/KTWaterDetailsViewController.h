//
//  KTWaterDetailsViewController.h
//  民生小区
//
//  Created by 罗芳芳 on 15/4/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WaterSending.h"
#import "WaterSendingDetails.h"
#import "CommodityEvaluationRequest.h"
@interface KTWaterDetailsViewController : UIViewController

@property (strong, nonatomic) CommodityEvaluationList *commodityList;

@property (assign, nonatomic) WaterSendingDetails *ID;

@property (nonatomic, strong) WaterSending *waterSending;
@property (strong, nonatomic)  UILabel *test;

//@property (nonatomic, strong) UIButton *minusBtn;//加按钮
//@property (nonatomic, strong) UIButton *addBtn;// 减按钮
//@property (nonatomic, strong) UILabel *numLabel;


@end
