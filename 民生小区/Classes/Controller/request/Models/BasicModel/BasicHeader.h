//
//  BasicHeader.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicHeader : NSObject

/**errorCode   返回码*/
@property (assign,nonatomic) NSInteger errorCode;

/**message  返回消息*/
@property (copy,nonatomic) NSString *message;
@end
/**
 "responseHeader":
	{
	"errorCode":"0000",
	"message":"查询商品评价成功"
	},
 */