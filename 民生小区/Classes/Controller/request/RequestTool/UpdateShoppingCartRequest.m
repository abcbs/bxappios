//
//  UpdateShoppingCartRequest.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UpdateShoppingCartRequest.h"

@implementation UpdateShoppingCartRequest

+ (void)updateShoppingCartWith:(UpdateShoppingCartParams *)params block:(void (^)(UpdateShoppingCartResult *, NSError *, BasicHeader *))block
{
    //http://{XXXX:XX}/shoppingcart/updatecart
    
    [[MiddleNetWorkTool sharedBasicNetWork] postWithUrl:[Conf urlWaterShoppingUpdateCart] params:params.keyValues success:^(id json) {
        UpdateShoppingCartResult *result = [UpdateShoppingCartResult objectWithKeyValues:json];
        
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
