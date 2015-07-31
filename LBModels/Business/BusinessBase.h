//
//  BusinessBase.h
//  KTAPP
//  商家基本信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resources.h"

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

//营业执照
@property (retain,nonatomic) NSString *commerceLicense;

@property (retain,nonatomic) UIImage  *headerImage;//用户id

//资源ID转换之后为UIImage
@property (strong, nonatomic) Resources *resourceInfo;

//商家资源IDs
@property (strong,nonatomic) NSMutableArray * resourceIds;

//商家资源图片集
@property (strong,nonatomic) NSMutableArray * resourceImages;

//商家组播图片资源
@property (strong,nonatomic) NSMutableArray * resourceInfoArray;

@end
