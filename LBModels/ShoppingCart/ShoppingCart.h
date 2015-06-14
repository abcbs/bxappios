//
//  ShoppingCart.h
//  民生小区
//
//  Created by LouJQ on 15-5-14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ErrorMessage.h"

@class ErrorMessage;

@interface ShoppingCart : NSObject

@property (nonatomic, assign) NSString *countorder;

@property (nonatomic, assign) NSNumber *businessProductId;

@property (nonatomic, assign) long id;

@property (nonatomic, assign)NSString *sessionId;

@property (nonatomic, assign) NSNumber *currentCount;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)initShoppingCartWithDic:(NSDictionary *)dic;



+(void)addCart:(ShoppingCart * )shoppingCart
blockArray:(void (^)(NSError *error,ErrorMessage *errorMessage))block;

@end
