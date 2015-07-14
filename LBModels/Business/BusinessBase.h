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

@property (retain,nonatomic) NSString * name;//商家名称

@property (retain,nonatomic) NSString * address;//商家地址

@property (retain,nonatomic) NSString * geo;//商家地理信息

@property (retain,nonatomic) NSString * status;//商家状态

@property (retain,nonatomic) NSDate * updateTime;//更新时间

@property (retain,nonatomic) NSString * contractname;//联系人

@property (assign,nonatomic) NSInteger productcatalogueid;//产品分类

@property (retain,nonatomic) NSString * paytool;//支付工具

@property (assign,nonatomic) NSInteger  userid;//用户id


@end
