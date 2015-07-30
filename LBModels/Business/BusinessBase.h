//
//  BusinessBase.h
//  KTAPP
//  商家基本信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessBase : NSObject

@property (assign,nonatomic) NSInteger id;

//商家唯一标示，需服务端提供
@property (assign,nonatomic) NSString * identifer;

@property (retain,nonatomic) NSString * name;//商家名称
//商家地址，经营地址
@property (retain,nonatomic) NSString * address;//商家地址

@property (retain,nonatomic) NSString * geo;//商家地理信息

@property (retain,nonatomic) NSString * status;//商家状态

@property (retain,nonatomic) NSDate * updateTime;//更新时间

@property (retain,nonatomic) NSString * introduce;//商家介绍

@property (retain,nonatomic) NSString * payTool;//支付工具

//@property (assign,nonatomic) NSInteger  userId;//用户id


@end
