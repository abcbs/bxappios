//
//  BusinessProductOffsale.h
//  KTAPP
//  产品上下架
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductOffsale : NSObject

    @property (assign,nonatomic) NSInteger id;

    @property (assign,nonatomic) NSInteger businessProductId;

    @property (retain,nonatomic) NSString * comment;

    @property (retain,nonatomic) NSString * aduitstatus;

    @property (retain,nonatomic) NSDate * updatetime;

    @property (assign,nonatomic) NSInteger bussinessId;

    @property (retain,nonatomic) NSString * status;
@end
