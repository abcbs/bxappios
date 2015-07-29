//
//  ProductCatalogue.h
//  KTAPP
//  商品分类,
//  目前，送水为1001
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCatalogue : NSObject

//编码
@property (retain,nonatomic) NSString *code;
//备注
@property (retain,nonatomic) NSString *comment;
//状态
@property (retain,nonatomic) NSString *status;
//更新时间
@property (retain,nonatomic) NSDate *updateTime;

@property (assign,nonatomic) NSInteger serialize;

@end
