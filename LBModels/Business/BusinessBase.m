//
//  BusinessBase.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessBase.h"

@implementation BusinessBase

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger: _id forKey:@"id"];
    
    [aCoder encodeObject:_name forKey:@"name"];//商家名称
    
    [aCoder encodeObject:_address forKey:@"address"];//商家地址
    
    [aCoder encodeObject:_geo forKey:@"geo"];//商家地理信息
    
    [aCoder encodeObject:_status forKey:@"status"];//商家状态
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];//更新时间
    
    [aCoder encodeObject:_introduce forKey:@"introduce"];//介绍信息

    
    //[aCoder encodeObject:_productCatalogues
     //              forKey:@"productCatalogues"] ;//产品分类
    
    [aCoder encodeObject:_payTool forKey:@"payTool"];//支付工具
    
    //[aCoder encodeInteger:_userId forKey:@"userid"];//用户id
    
    [aCoder encodeObject:_identifer forKey:@"identifer"];//商户唯一标示


    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _name= [aDecoder decodeObjectForKey:@"name"];//商家名称
    
    _address= [aDecoder decodeObjectForKey:@"address"];//商家地址
    
    _geo= [aDecoder decodeObjectForKey:@"geo"];//商家地理信息
    
    _status= [aDecoder decodeObjectForKey:@"status"];//商家状态
    
    _updateTime= [aDecoder decodeObjectForKey:@"updateTime"];//更新时间
    
    _introduce= [aDecoder decodeObjectForKey:@"introduce"];//介绍信息
    
    //_productCatalogues=
    //               [aDecoder decodeObjectForKey:@"productCatalogues"] ;//产品分类
    
    _payTool= [aDecoder decodeObjectForKey:@"payTool"];//支付工具
    
    //_userId =[aDecoder decodeIntegerForKey:@"userid"];//用户id

    _identifer =[aDecoder decodeObjectForKey:@"identifer"];//商户唯一标示
    return self;
    
}


-(NSString *)description{
    return [NSString stringWithFormat:@"商家基本信息:%ld，商家名称:%@",
            (long)self.id,self.name];
}


@end
