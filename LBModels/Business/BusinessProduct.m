//
//  BusinessProduct.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProduct.h"

@implementation BusinessProduct

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInteger: _id forKey:@"id"];
    
    [aCoder encodeInteger:_productCatalogueId forKey:@"productCatalogueId"];
    
    [aCoder encodeInteger:_productBaseId forKey:@"productBaseId"];
    
    [aCoder encodeObject:_businessName forKey:@"businessName"];
    
    [aCoder encodeInteger:_numbers forKey:@"numbers"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    //商品介绍
    [aCoder encodeObject:_introduce forKey:@"introduce"];
    
    //商品发布时间
    [aCoder encodeObject:_publishTime forKey:@"publishTime"];
    
    //系统更新时间
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeObject:_warmPrompt forKey:@"warmPrompt"];
    //赞
    [aCoder encodeObject:_prasie forKey:@"prasie"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    //float 单价
    [aCoder encodeFloat: _unitPrice forKey:@"unitPrice"];
    
    //优惠价
    [aCoder encodeFloat: _preferPrice forKey:@"preferPrice"];
    
    //销售价格
    [aCoder encodeFloat: _salePrice forKey:@"salePrice"];
    
    //促销开始时间
    [aCoder encodeObject:_saleStartTime forKey:@"saleStartTime"];
    
    //结束时间
    [aCoder encodeObject:_saleOverTime forKey:@"saleOverTime"];
    
    //商家标示
    [aCoder encodeInteger: _businessId forKey:@"businessId"];
    //商品审核标示
    [aCoder encodeInteger: _businessProductAduit
                    forKey:@"businessProductAduit"];
    
    //是否在售
    [aCoder encodeObject:_isSale forKey:@"isSale"];
    
    //头像资源ID
    [aCoder encodeInteger: _resourceId forKey:@"resourceId"];
    
    //商品资源ID
    [aCoder encodeObject:_resourceIds forKey:@"resourceIds"];
    
    //是否降价
    [aCoder encodeObject:_onSale forKey:@"onSale"];
    
    //排序
    [aCoder encodeInteger: _order forKey:@"order"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _id = [aDecoder decodeIntegerForKey:@"id"];
    
    _productCatalogueId = [aDecoder decodeIntegerForKey:@"productCatalogueId"];
    
    _productBaseId = [aDecoder decodeIntegerForKey:@"productBaseId"];
    
    _businessName = [aDecoder decodeObjectForKey:@"businessName"];
    
    _numbers = [aDecoder decodeIntegerForKey:@"numbers"];
    
    _name = [aDecoder decodeObjectForKey:@"name"];
    
    //商品介绍
    _introduce=[aDecoder decodeObjectForKey:@"introduce"];
    
    //商品发布时间
    _publishTime=[aDecoder decodeObjectForKey:@"publishTime"];
    
    //系统更新时间
    _updateTime=[aDecoder decodeObjectForKey:@"updateTime"];
    
    _warmPrompt=[aDecoder decodeObjectForKey:@"warmPrompt"];
    //赞
    _prasie =[aDecoder decodeObjectForKey:@"prasie"];
    
    _status =[aDecoder decodeObjectForKey:@"status"];
    
    //float 单价
    _unitPrice =[aDecoder decodeFloatForKey:@"unitPrice"];
    
    //优惠价
    _preferPrice =[aDecoder decodeFloatForKey:@"preferPrice"];
    
    //销售价格
    _salePrice =[aDecoder decodeFloatForKey:@"salePrice"];
    
    //促销开始时间
    _saleStartTime =[aDecoder decodeObjectForKey:@"saleStartTime"];
    
    //结束时间
    _saleOverTime =[aDecoder decodeObjectForKey:@"saleOverTime"];
    
    //商家标示
    _businessId =[aDecoder decodeIntegerForKey:@"businessId"];
    //商品审核标示
    _businessProductAduit=[aDecoder decodeIntegerForKey:@"businessProductAduit"];
    
    //是否在售
    _isSale =[aDecoder decodeObjectForKey:@"isSale"];
    
    //头像资源ID
    _resourceId =[aDecoder decodeIntegerForKey:@"resourceId"];
    
    //商品资源ID
    _resourceIds =[aDecoder decodeObjectForKey:@"resourceIds"];
    
    //是否降价
    _onSale =[aDecoder decodeObjectForKey:@"onSale"];
    
    //排序
     _order =[aDecoder decodeIntegerForKey:@"order"];

    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"商家产品\t%lid, :商品分类 %ld, 商家名称: %@ \t商品名称: %@", (long)_id, (long)_productCatalogueId, _businessName, _name];
}

@end
