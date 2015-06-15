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
    
    BSHTTPNetworking *manager = [BSHTTPNetworking manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [responseObject objectForKey:@"responseHeader"];
        if ([[result objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = [responseObject objectForKey:@"responseBody"];
           for (NSDictionary *dict in resultArr) {
               
               [waterSendingDetails.comments addObject: [Comment commentWithDic:dict]];
               waterSendingDetails.firstComment= [Comment commentWithDic:dict];
           }
           if (block) {
                block(waterSendingDetails, nil,nil);
            }
 
        }else{
            ErrorMessage *error = [ErrorMessage initWith:result];
            block( nil,nil,error);
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil,error,nil);
        }
        NSLog(@"失败结果: %@", error);
        
    }];
    }


+ (WaterSendingDetails *)listProductUrls:(WaterSending *)waterSending dataCount:(int)dataCount
             blockArray:(void (^)( NSError *error,ErrorMessage *errorMessage))block{
    return nil;
    
}


@end
