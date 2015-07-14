//
//  BusinessCatalogue.h
//  KTAPP
//  商家分类，一个商家可以属于多个类型
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCatalogue : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger businessid;
//参考商品分类
@property (assign,nonatomic) NSInteger cataloguecode;

@property (retain,nonatomic) NSString * name;

@property (retain,nonatomic) NSDate * updatetime;

@end
