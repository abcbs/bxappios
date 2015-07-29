//
//  CustomerCancleOrder.h
//  KTAPP
//  客户取消订单
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerCancleOrder : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger businessProductId;

@property (assign,nonatomic) NSInteger businessId;

@property (retain,nonatomic) NSString * comment;

@property (retain,nonatomic) NSString * status;

@end
