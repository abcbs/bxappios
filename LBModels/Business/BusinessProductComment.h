//
//  BusinessProductComment.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessProductComment : NSObject

@property (assign,nonatomic) NSInteger id;

@property (assign,nonatomic) NSInteger businessProductId;

@property (retain,nonatomic) NSString * comment;

@property (assign,nonatomic) NSInteger productBaseId;

@property (retain,nonatomic) NSString * userName;

@property (assign,nonatomic) NSInteger userBaseId;

@property (retain,nonatomic) NSString * status;

@property (retain,nonatomic) NSDate * updateTime;

@end
