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
#import "ShoppingCart.h"

@interface KTWaterDetailsViewController : UIViewController

@property (strong, nonatomic) WaterSendingDetails *waterSendingDetails;

@property (nonatomic, strong) WaterSending *waterSending;

@property (nonatomic, strong) ShoppingCart *shoppingCart;

- (IBAction)backButton:(id)sender;


@end
