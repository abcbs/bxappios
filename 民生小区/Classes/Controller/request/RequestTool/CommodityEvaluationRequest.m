//
//  CommodityEvaluationRequest.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CommodityEvaluationRequest.h"

@implementation CommodityEvaluationRequest

+ (void)commodityEvaluationWith:(CommodityEvaluationParams *)params block:(void (^)(CommodityEvaluationResult *, NSError *, BasicHeader *))block
{
    //http://{XXXX:XX}/productcomment/productcomments/{productId}/{maxId}/{dataCount}
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@",WATER_DETAIL_COMMENT,params.productId,params.maxId,params.dataCount];
    
    [[MiddleNetWorkTool sharedBasicNetWork] getWithUrl:url params:nil success:^(id json) {
        
        NSLog(@"%@",json);
        
        CommodityEvaluationResult *result  = [CommodityEvaluationResult objectWithKeyValues:json];
        
        if (result.responseHeader.errorCode == 0000) {
            if (block) {
                block(result,nil,nil);
            }
        }else{
            if (block) {
                block(nil,nil,result.responseHeader);
            }
        }
        
        
    } failure:^(NSError *error) {
        if (block) {
            block(nil,error,nil);
        }
    }];
    
}

@end
