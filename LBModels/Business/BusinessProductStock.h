//
//  BusinessProductStock.h
//  KTAPP
//  商家产品库存管理
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductStock : NSObject

    @property (assign,nonatomic) NSInteger id;

    @property (assign,nonatomic) NSInteger  productId;

    @property (assign,nonatomic) NSInteger businessId;

    @property (assign,nonatomic) NSInteger businessProductId;

    @property (retain,nonatomic) NSString * status;

    @property (retain,nonatomic) NSDate * updateTime;

    @property (retain,nonatomic) NSString * name;

    @property (assign,nonatomic) NSInteger numbers;

@end
