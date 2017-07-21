//
//  WaterSending.h
//  民生小区
//
//  Created by L on 15/4/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorMessage.h"
#import "MJExtension.h"
#import "BSHTTPNetworking.h"

@interface WaterSending : NSObject


@property (nonatomic, assign) int businessId;

@property (nonatomic, copy) NSString *businessName;

@property (nonatomic, assign) int id;

@property (nonatomic, copy) NSString *introduce; //商品简介

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int preferPrice;


@property (nonatomic, strong) NSString *publishTime; //发布时间

@property (nonatomic, assign) int resourceId;

@property (nonatomic, assign) int salePrice;

@property (nonatomic, assign) int unitPrice;

@property (nonatomic, copy) NSString *count;

@property (readonly, nonatomic, unsafe_unretained) NSURL *avatarImageURL;


+ (void)listWaterList:(long)maxId dataCount:(int)dataCount
                       errorUILabel:( UILabel *)errorUILabel
                       block:(BSHTTPResponse)block;

@end
