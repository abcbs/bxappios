//
//  ShoppingCartDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShoppingCart;

@interface ShoppingCartDomain : NSObject

@property(retain,nonatomic) ShoppingCart *shoppingCart;

@property(retain,nonatomic) NSString *sessionId;

@end
