//
//  WaterSendingDetails.h
//  民生小区
//
//  Created by 罗芳芳 on 15/4/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ErrorMessage;
@class WaterSending;
@class Comment;

@interface WaterSendingDetails : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int businessProductId;
@property (nonatomic,strong,readwrite)NSMutableArray *comments;

@property (nonatomic,strong)NSMutableArray *productUrls;

@property (nonatomic, strong) WaterSending *water;

@property (nonatomic,strong)Comment *firstComment;

- (instancetype)initWaterDetailsWithWaterSending:(WaterSending *)waterSending;

//
- (instancetype)initWithDic:(NSDictionary *)dic;

//+ (void)waterSendingDetails:(long)productId;

+ (void) listComments:(WaterSending *)waterSending maxId:(long)maxId dataCount:(int)dataCount
          blockArray:(void (^)(WaterSendingDetails * waterSendingDetails,NSError *error,ErrorMessage *errorMessage))block;


+ (WaterSendingDetails *)listProductUrls:(WaterSending *)waterSending dataCount:(int)dataCount
                      blockArray:(void (^)( NSError *error,ErrorMessage *errorMessage))block;

@end
