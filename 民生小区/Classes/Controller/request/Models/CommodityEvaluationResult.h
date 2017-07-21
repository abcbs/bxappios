//
//  CommodityEvaluationResult.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  商品评价 信息


#import "BasicResponse.h"

@interface CommodityEvaluationResult : BasicResponse

/**responseBody*/
@property (strong,nonatomic) NSArray *responseBody;

@end


@interface CommodityEvaluationList : NSObject

/**id	Long	评价ID，主键*/
@property (strong,nonatomic) NSNumber *ID;
/** businessProductId	Long	产品ID*/
@property (strong,nonatomic)  NSString *businessProductId;
/** comment	String	评论内容*/
@property (copy,nonatomic) NSString *comment;
/**username	String	评价人姓名*/
@property (copy,nonatomic) NSString *username;
/** userBaseId	Long	用户ID*/
@property (strong,nonatomic) NSNumber *userBaseId   ;
/** updateTime	Date	更新时间*/
@property (assign,nonatomic) NSTimeInterval updateTime;

@end
