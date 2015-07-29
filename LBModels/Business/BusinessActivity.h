//
//  BusinessActivity.h
//  KTAPP
//  商家活动
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessActivity : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString * title;

@property (retain,nonatomic) NSString * content;

@property (retain,nonatomic) NSDate *startTime;

@property (retain,nonatomic) NSDate *endTime;
//活动地点
@property (retain,nonatomic) NSString * place;

@property (retain,nonatomic) NSString * status;

@property (retain,nonatomic) NSString * isEnabled;

@end
