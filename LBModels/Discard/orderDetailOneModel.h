//
//  orderDetailOneModel.h
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderDetailOneModel : NSObject
//商家地址
@property (nonatomic, strong) NSString *address;
//contractname
@property (nonatomic, strong) NSString *contractname;
//商家id
@property (nonatomic, strong) NSString *id;
//商家名称
@property (nonatomic, strong) NSString *businessName;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)myOrderDetailWithDic:(NSDictionary *)dic;
@end
