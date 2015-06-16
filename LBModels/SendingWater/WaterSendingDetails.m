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


- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.water = [[WaterSending alloc] initWithDic:[dic valueForKeyPath:@"water"]];
  
    return self;
}


- (instancetype)initWaterDetailsWithWaterSending:(WaterSending *)waterSending
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _water = waterSending;
    _comments= [NSMutableArray arrayWithCapacity:10];
    
    return self;
}


+ (void)listComments:(WaterSending *)waterSending maxId:(long)maxId dataCount:(int)dataCount
                 blockArray:(void (^)(WaterSendingDetails * waterSendingDetails,NSError *error,ErrorMessage *errorMessage))block
{
    
    NSString *pathparam = [NSString stringWithFormat:@"%d/%ld/%d",
                           waterSending.id,maxId,dataCount];
    NSLog(@"pathparam:%@", pathparam);
    
    NSString *url=[[Conf urlWaterDetailComment]  stringByAppendingString:pathparam];
    __block WaterSendingDetails * waterSendingDetails=[[self alloc] initWaterDetailsWithWaterSending:waterSending];
    NSLog(@"url:%@", url);
    NSString *restParam=[[Conf urlWaterDetailComment]  stringByAppendingString:pathparam];
    //BSHTTPNetworking *bsHttp=[BSHTTPNetworking httpManager];
    [BSHTTPNetworking httpGET:restParam
    pathPattern:WATER_DETAIL_COMMENT_SCHEMA
     modelClass:[Comment class]
        keyPath:@"Comment"
          block:^(NSObject *waters,NSError *error, ErrorMessage *bsErrorMessage){
              if (block&&waters!=nil) {
                  NSArray *comments=(NSArray *)waters;
                  [waterSendingDetails.comments addObjectsFromArray:comments];                  waterSendingDetails.firstComment= [comments firstObject];                  block((WaterSendingDetails *)waters,nil,nil);
              }else if(block&&error){
                  block(nil,error,nil);
              }else{
                  block(nil,nil,bsErrorMessage);
              }
          }
     ];
    }


+ (WaterSendingDetails *)listProductUrls:(WaterSending *)waterSending dataCount:(int)dataCount
             blockArray:(void (^)( NSError *error,ErrorMessage *errorMessage))block{
    return nil;
    
}


@end
