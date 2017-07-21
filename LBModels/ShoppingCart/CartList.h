//
//  CartList.h
//  民生小区
//  购物车列表
//  Created by 罗芳芳 on 15/5/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorMessage.h"
//#import ""
@interface CartList : NSObject


@property (nonatomic, assign)BOOL selected;
@property (nonatomic, assign) long cartId;//产品数量

@property (nonatomic, assign) NSNumber *businessProductId;//商家产品信息ID

@property (nonatomic,copy) NSString *productName;

@property (nonatomic, copy)NSString *productIntroduce;

@property (nonatomic, copy) NSString *productSalePrice;

@property (nonatomic,copy) NSString *productPreferPrice;

@property (nonatomic, assign) long resourceId;

@property (nonatomic, strong) NSArray *waters;


+ (void)queryShoppingCart:(NSString *)sessionId
                       blockArray:(void (^)(NSMutableArray *waters, NSError *error,ErrorMessage *errorMessage))block;


@end
