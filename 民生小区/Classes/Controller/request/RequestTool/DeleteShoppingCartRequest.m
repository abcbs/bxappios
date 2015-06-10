//
//  DeleteShoppingCartRequest.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "DeleteShoppingCartRequest.h"

@implementation DeleteShoppingCartRequest

+ (void)deleteShoppingCartWith:(DeleteShoppingCartParams *)params block:(void (^)(DeleteShoppingCartResult *, NSError *, BasicHeader *))block
{
    [[MiddleNetWorkTool sharedBasicNetWork] putWithUrl:[Conf urlWaterShoppingDelcartlist] params:params.keyValues success:^(id json) {
        DeleteShoppingCartResult *result = [DeleteShoppingCartResult objectWithKeyValues:json];
        
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
