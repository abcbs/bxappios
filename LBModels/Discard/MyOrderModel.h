//
//  MyOrderModel.h
//  民生小区
//
//  Created by 闫青青 on 15/5/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
//订单号
@property (nonatomic, strong) NSString *orderNumber;
//订单ID
@property (nonatomic, assign) long int id;
//总价
@property (nonatomic, assign) float totalCash;
//总数量
@property (nonatomic, assign) int totalNumbers;
//订单更新时间
@property (nonatomic, strong) NSString *updateTime;
//订单详细状态
@property (nonatomic, strong) NSString *detailedAduit;
//订单状态
@property (nonatomic, strong) NSString *status;
//用户ID
@property (nonatomic, strong) NSString *userBaseId;
//@property (nonatomic, copy) NSArray *array;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)myOrderWithDic:(NSDictionary *)dic;
//调用我的订单方法
//- (void)myOrder;
@end
