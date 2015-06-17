//
//  WaterSendingDetails.h
//  民生小区
//
//  Created by 罗芳芳 on 15/4/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSHTTPNetworking.h"

@class ErrorMessage;
@class WaterSending;
@class Comment;

@interface WaterSendingDetails : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int businessProductId;
@property (nonatomic,strong,readwrite) NSMutableArray *comments;

@property (nonatomic,strong) NSMutableArray *productUrls;

@property (nonatomic, strong) WaterSending *water;

@property (nonatomic,strong)Comment *firstComment;


+ (void) listComments:(WaterSending *)waterSending maxId:(long)maxId
            dataCount:(int)dataCount
            errorUILabel:( UILabel *)errorUILabel
            blockArray:(BSHTTPResponse)block;


+ (void)listProductUrls:(WaterSending *)waterSending
                                dataCount:(int)dataCount
                                errorUILabel:( UILabel *)errorUILabel
                                blockArray:(BSHTTPResponse)block;

@end
