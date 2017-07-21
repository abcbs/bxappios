//
//  BusinessProductAdvert.h
//  KTAPP
//  商家商品广告信息
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductAdvert : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger productBaseId;

@property (assign,nonatomic) NSInteger businessId;

@property (retain,nonatomic) NSString * troduce;

@property (assign,nonatomic) NSInteger resourceId;

@property (retain,nonatomic) NSDate * startTime;

@property (retain,nonatomic) NSDate * endTime;

@property (retain,nonatomic) NSString * status;

@property (retain,nonatomic) NSDate * updateTime;


@end
