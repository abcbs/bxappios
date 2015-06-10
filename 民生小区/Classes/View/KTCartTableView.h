//
//  KTCartTableView.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterSending.h"
@interface KTCartTableView : UIViewController
//@property (nonatomic, strong) WaterSending *waterSending;
@property (nonatomic, strong)NSMutableArray *waterSendingArray;

@property (nonatomic,strong)NSMutableArray *modelList;

@property (nonatomic, assign) NSString *cartId;

@property (nonatomic, assign)NSString *businessProductId;

@property (nonatomic, strong) NSString *shoppingCart;

@end
