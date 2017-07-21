//
//  JoinShoppingCartRequest.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "JoinShoppingCartRequest.h"

@implementation JoinShoppingCartRequest

+ (void)joinShoppingCartWith:(JoinShoppingCartParams *)params block:(void (^)(JoinShoppingCartResult *, NSError *, BasicHeader *))block
{
//    http://{XXXX:XX}/shoppingcart/addcart
    NSLog(@"%@",params.keyValues);
    
    [[MiddleNetWorkTool sharedBasicNetWork] postWithUrl:[Conf urlWithAddShoppingCart] params:params.keyValues success:^(id json) {
        JoinShoppingCartResult *result = [JoinShoppingCartResult objectWithKeyValues:json];
        
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
