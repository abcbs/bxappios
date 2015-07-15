//
//  ProductBase.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ProductBase.h"

@implementation ProductBase

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    //id
    [aCoder encodeInteger:_id forKey:@"id"];
    
    //商品名称
    [aCoder encodeObject:_name forKey:@"name"];
    
    //商品介绍
    [aCoder encodeObject:_introduce forKey:@"introduce"];
    
    //更新时间
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    //状态
    [aCoder encodeObject:_status forKey:@"status"];
    
    
    //单价，标准价格
    [aCoder encodeObject:_unit forKey:@"unit"];
    //商品规格
    [aCoder encodeInteger:_specification forKey:@"specification"];
    
    //商品备注
    [aCoder encodeInteger:_comment forKey:@"comment"];
    
    //商品分类，应当引用ProductCatalogue
    [aCoder encodeInteger:_productCatalogueId forKey:@"productCatalogueId"];
    
    [aCoder encodeInteger:_catalogue forKey:@"catalogue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    //id
    _id=[aDecoder decodeIntegerForKey:@"id"];
    
    //商品名称
    _name=[aDecoder decodeObjectForKey:@"name"];
    
    //商品介绍
    _introduce=[aDecoder decodeObjectForKey:@"introduce"];
    
    //更新时间
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
    
    //状态
    _status=[aDecoder decodeObjectForKey:@"status"];
    
    //单价，标准价格
    _unit=[aDecoder decodeObjectForKey:@"unit"];
    
    //商品规格
    _specification=[aDecoder decodeObjectForKey:@"specification"];
    
    //商品备注
    _comment=[aDecoder decodeObjectForKey:@"comment"];
    
    //商品分类，应当引用ProductCatalogue
    _productCatalogueId=[aDecoder decodeIntegerForKey:@"productCatalogueId"];
    
    _catalogue=[aDecoder decodeObjectForKey:@"catalogue"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商品基本信息\t%lid, 名称: %@ \t分类: %ld", (long)_id, _name, (long)_productCatalogueId];
}
@end
