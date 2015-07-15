//
//  UserOrderAddress.h
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserOrderAddress : NSObject

@property (assign,nonatomic) NSInteger id;

@property (retain,nonatomic) NSString * name; //收货人姓名

@property (retain,nonatomic) NSString * address; //收货人地址

@property (retain,nonatomic) NSString * phone; //收货人电话

@property (retain,nonatomic) NSDate * updateTime;

@property (assign,nonatomic) NSInteger userId;

@property (retain,nonatomic) NSString * addressType;

@property (retain,nonatomic) NSString * status;

@end
