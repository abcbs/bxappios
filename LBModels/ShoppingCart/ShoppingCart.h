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

@property (nonatomic, strong) NSString *countorder;

@property (nonatomic, strong) NSNumber *businessProductId;

@property (nonatomic, assign) long id;

@property (nonatomic, strong)NSString *sessionId;

@property (nonatomic, strong) NSNumber *currentCount;


+(void)addCart:(ShoppingCart * )shoppingCart
blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

@end
