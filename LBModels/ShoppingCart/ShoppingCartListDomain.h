//
//  ShoppingCartListDomain.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartListDomain : NSObject

@property(retain,nonatomic) NSString *sessionId;

@property(strong,nonatomic) NSMutableArray* shoppingCartList;


@end
