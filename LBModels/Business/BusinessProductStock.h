//
//  BusinessProductStock.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductStock : NSObject

    @property (assign,nonatomic) NSInteger id;

    @property (assign,nonatomic) NSInteger  productid;

    @property (assign,nonatomic) NSInteger businessid;

    @property (assign,nonatomic) NSInteger businessproductid;

    @property (retain,nonatomic) NSString * status;

    @property (retain,nonatomic) NSDate * updatetime;

    @property (retain,nonatomic) NSString * name;

    @property (assign,nonatomic) NSInteger numbers;

@end
