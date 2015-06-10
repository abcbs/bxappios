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

@property (nonatomic, assign) NSString *businessProductId;

@property (nonatomic, assign) long ID;

@property (nonatomic, assign)NSString *sessionId;

@property (nonatomic, assign) NSString *currentCount;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)initShoppingCartWithDic:(NSDictionary *)dic;



+(void)addCart:(ShoppingCart * )shoppingCart
blockArray:(void (^)(NSError *error,ErrorMessage *errorMessage))block;

@end
