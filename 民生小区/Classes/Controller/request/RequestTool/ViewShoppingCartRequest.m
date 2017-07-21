//
//  ViewShoppingCartRequest.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  查看购物车

#import "ViewShoppingCartRequest.h"

@implementation ViewShoppingCartRequest
+ (void)viewShoppingCartWith:(ViewShoppingCartParams *)params block:(void (^)(ViewShoppingCartResult *, NSError *, BasicHeader *))block
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",[Conf urlWithShoppingCart],params.sessionId];
    
    [[MiddleNetWorkTool sharedBasicNetWork] getWithUrl:url params:nil success:^(id json) {
        ViewShoppingCartResult *result = [ViewShoppingCartResult objectWithKeyValues:json];
        
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
