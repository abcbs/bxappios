//
//  User.m
//  APP-BS-MODEL
//  LoginUser
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LoginUser.h"

@implementation LoginUser

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //用户名
    [aCoder encodeObject:_username forKey:@"username"];
    
    //真实姓名
    [aCoder encodeObject:_realName forKey:@"realName"];
    
    //性别
    [aCoder encodeObject:_sex forKey:@"sex"];
    
    //手机号
    [aCoder encodeObject:_phoneNum forKey:@"phoneNum"];
    
    //验证码
    [aCoder encodeObject:_yanZhengCode forKey:@"yanZhengCode"];
    
    //密码
    [aCoder encodeObject:_password forKey:@"password"];
    
    //确认密码
    [aCoder encodeObject:_commitCode forKey:@"commitCode"];
    
    //详细地址
    [aCoder encodeObject:_address forKey:@"address"];

    
    [aCoder encodeObject:_headerImage forKey:@"headerImage"];
 
    //[aCoder encodeInteger:_resourceId forKey:@"resourceId"];
    
    [aCoder encodeObject:_resourceInfo forKey:@"resourceInfo"];
    
    [aCoder encodeInteger:_userId forKey:@"userId"];
    
    [aCoder encodeInteger:_businessId forKey:@"businessId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    //用户名
    _username=[aDecoder decodeObjectForKey:@"username"];
    //真实姓名
    _realName=[aDecoder decodeObjectForKey:@"realName"];
    //性别
    _sex =[aDecoder decodeObjectForKey:@"sex"];
    
    //手机号
    _phoneNum=[aDecoder decodeObjectForKey:@"phoneNum"];
    
    //验证码
    _yanZhengCode=[aDecoder decodeObjectForKey:@"yanZhengCode"];
    
    //密码
    _password=[aDecoder decodeObjectForKey:@"password"];
    
    //确认密码
    _commitCode=[aDecoder decodeObjectForKey:@"commitCode"];
    
    //详细地址
    _address=[aDecoder decodeObjectForKey:@"address"];
    
    _headerImage=[aDecoder decodeObjectForKey:@"headerImage"];
    
    _resourceInfo=[aDecoder decodeObjectForKey:@"resourceInfo"];
    
    _userId=[aDecoder decodeObjectForKey:@"userId"];
    
    _businessId=[aDecoder decodeObjectForKey:@"businessId"];
    
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"用户信息\t%@ \t用户标示: %ld", _username,(long)_userId];
}
@end
