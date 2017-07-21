//
//  ViewShoppingCartResult.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  查看购物车 返回信息

#import "BasicResponse.h"

@interface ViewShoppingCartResult : BasicResponse
/**responseBody*/
@property (strong,nonatomic) NSArray *responseBody;
@end

@interface ViewShoppingCartDict : NSObject
/**cartId Long 购物车ID*/
@property (strong,nonatomic) NSNumber *cartId;
/**businessProductId Long 产品ID*/
@property (strong,nonatomic) NSNumber *businessProductId;
/** productName String  产品名称*/
@property (strong,nonatomic) NSNumber *productName;
/**productIntroduce String 产品简介*/
@property (copy,nonatomic) NSString *productIntroduce;
/** productSalePrice Folat 产品促销价格*/
@property (strong,nonatomic) NSNumber *productSalePrice;
/**productPreferPrice Folat 产品德阳银行卡价*/
@property (strong,nonatomic) NSNumber *productPreferPrice;
/** resourceId Long 资源ID 通过此ID查看产品图片*/
@property (strong,nonatomic) NSNumber *resourceId;
@end
