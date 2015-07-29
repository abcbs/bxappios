//
//  UserPay.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserPay.h"

@implementation UserPay

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInteger:_id forKey:@"id"];
    
    [aCoder encodeObject:_payTool forKey:@"payTool"];
    
    [aCoder encodeObject:_cvv  forKey:@"cvv"];
    
    [aCoder encodeObject:_status  forKey:@"status"];
    
    [aCoder encodeObject:_name  forKey:@"name"];
    
    [aCoder encodeObject:_phone  forKey:@"phone"];
    
    [aCoder encodeObject:_certificateType
                  forKey:@"certificateType"]; //证件类型
    
    [aCoder encodeObject:_certificateNumber
                  forKey:@"certificateNumber"]; //证件号码
    
    [aCoder encodeObject:_updateTime  forKey:@"updateTime"];
    
    [aCoder encodeInteger:_userId forKey:@"userId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    
    _id=[aDecoder decodeIntegerForKey:@"id"];
    
    _payTool=[aDecoder decodeObjectForKey:@"payTool"];
    
    _cvv=[aDecoder decodeObjectForKey:@"cvv"];
    
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    _name=[aDecoder decodeObjectForKey:@"name"];
    
    _phone=[aDecoder decodeObjectForKey:@"phone"];
    
    _certificateType=[aDecoder decodeObjectForKey:@"certificateType"]; //证件类型
    
    _certificateNumber=[aDecoder
                        decodeObjectForKey:@"certificateNumber"]; //证件号码
    
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
    
    _userId=[aDecoder decodeIntegerForKey:@"userId"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"支付工具\t%lid, :支付工具 %ld, 支付工具名称: %@ \t用户标示: %ld", (long)_id, (long)_payTool, _name, (long)_userId];
}
@end
