//
//  orderDetailModel.h
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderDetailModel : NSObject
//商品简介
@property (nonatomic, strong) NSString *goodIntroduce;
//商品单价
@property (nonatomic, assign) NSString *salesPrice;
//商品数量
@property (nonatomic, assign) NSInteger numbers;
//商品总价
@property (nonatomic, assign) NSString *total;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)myOrderDetailTwoWithDic:(NSDictionary *)dic;
@end
