//
//  WaterSendingDetails.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "WaterSendingDetails.h"
#import "Conf.h"
#import "ErrorMessage.h"
#import "WaterSending.h"
#import "Comment.h"
#import "BSHTTPNetworking.h"

@implementation WaterSendingDetails


+ (void) listComments:(WaterSending *)waterSending maxId:(long)maxId
            dataCount:(int)dataCount
         errorUILabel:( UILabel *)errorUILabel
           blockArray:(BSHTTPResponse)block
{
    
    NSString *pathparam = [NSString stringWithFormat:@"%d/%ld/%d",
                           waterSending.id,maxId,dataCount];
    
    NSString *restParam=[WATER_DETAIL_COMMENT  stringByAppendingString:pathparam];
 
    [BSHTTPNetworking httpGET:restParam
    pathPattern:WATER_DETAIL_COMMENT_SCHEMA
     modelClass:[Comment class]
        keyPath:@"Comment"
        block:(BSHTTPResponse)block
        errorUILabel:errorUILabel
     ];
    }

+ (void)listProductUrls:(WaterSending *)waterSending
                               dataCount:(int)dataCount
                            errorUILabel:( UILabel *)errorUILabel
                              blockArray:(BSHTTPResponse)block
{

}

@end
