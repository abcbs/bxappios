//
//  BusinessProductDomail.h
//  KTAPP
//  
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BusinessProduct;
@class BusinessProductComment;

@interface BusinessProductDomail : NSObject
//产品详细信息
@property (retain,nonatomic) BusinessProduct *pusinessProduct;

//产品评论信息
@property (retain,nonatomic) BusinessProductComment *businessProductComment;

@end
