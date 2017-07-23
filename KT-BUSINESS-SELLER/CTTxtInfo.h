//
//  CTTxtInfo.h
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTxtInfo : NSObject{
}

//商户管理
+(CTTxtInfo *)calTaxInfo;

//0-交易类型
+(NSInteger) transactionType;
//1-赠与类型
+(NSInteger) giftRelationshipType;
//2-房屋类型
+(NSInteger) houseType;
//3-买方住房记录类型
+(NSInteger) buyerHistType;
//4-卖方住房类型;
+(NSInteger) sellerHouseType;
//5-卖方购房年限类型
+(NSInteger) sellerFixedYearsType;
//6-卖方购房记录类型
+(NSInteger) sellerHouseRecordType;
//7-个人所得税征收方式
+(NSInteger) incomeTaxType;
//8-土地增值税征收方式
+(NSInteger) landTaxType;

+transactionTypeContent;
//个人所得税征收方式为据实征收选项
+(NSString *) incomeTaxTypeFactsContent;
//土地增值税征收方式，如果是据实征收
+(NSString *)landTaxTypeFactsContent;

#pragma mark -算税模型

#pragma mark -字典信息

//0-交易类型
+(NSArray *) transactionTypeData;
//1-赠与类型
+(NSArray *) giftRelationshipData;
//2-房屋类型
+(NSArray *) houseTypeData;
//3-买方住房记录类型
+(NSArray *) buyerHistTypeData;
//4-卖方住房类型
+(NSArray *) sellerHouseTypeData;
//5-卖方购房年限类型
+(NSArray *) sellerFixedYearsTypeData;
//6-卖方购房记录类型
+(NSArray *) sellerHouseRecordTypeData;
//7-个人所得税征收方式
+(NSArray *) incomeTaxTypeData;
//8-土地增值税征收方式
+(NSArray *) landTaxTypeData;

@property (assign,nonatomic) NSInteger id;

//个人所得税方式，如果是据实征收
@property (retain,nonatomic) NSString * incomeTaxTypeFacts;

//土地增值税征收方式，如果是据实征收
@property (retain,nonatomic) NSString * landTaxTypeFacts;

///////////////////////////////////////////////////////////
//0-交易类型
@property (assign,nonatomic) NSString * transactionTypeCurrent;

//1-赠与类型
@property (assign,nonatomic) NSString * giftRelationshipCurrent;

//2-房屋类型
@property (assign,nonatomic) NSString * houseTypeCurrent;

//3-买方住房记录类型
@property (assign,nonatomic) NSString * buyerHistTypeCurrent;

//4-卖方住房类型;
@property (assign,nonatomic) NSString * sellerHouseTypeCurrent;

//5-卖方购房年限类型
@property (assign,nonatomic) NSString * sellerFixedYearsTypeCurrent;

//6-卖方购房记录类型
@property (assign,nonatomic) NSString * sellerHouseRecordTypeCurrent;

//7-个人所得税征收方式
@property (assign,nonatomic) NSString *incomeTaxTypeCurrent;

//8-土地增值税征收方式
@property (assign,nonatomic) NSString * landTaxTypeCurrent;
////////////////////////////////////////////////////////////

//房屋建筑面积
@property (assign,nonatomic) float houseBuiltArea;
//网签价格
@property (assign,nonatomic) float onlineSignedPrice;
//核定价格
@property (assign,nonatomic) float approvedPrice;


//房屋原始价格
@property (assign,nonatomic) float houseRawPrice;
//房屋原始契税
@property (assign,nonatomic) float contractRawTax;
//装修费用
@property (assign,nonatomic) float renovationFax;
//贷款利息
@property (assign,nonatomic) float loanInterest;


//房屋原始价格-土地增值税
@property (assign,nonatomic) float houseRawPriceLand;
//房屋原始契税-土地增值税
@property (assign,nonatomic) float contractRawTaxLand;
//发票年限
@property (assign,nonatomic) float invoicesYearLimit;

////////////////////////////////////////////////////////
//买方信息-契税

//买方信息-契税税率
@property (assign,nonatomic) float contractTaxRateSeller;
@property (assign,nonatomic) float contractTaxSeller;

//买方信息-印花税
@property (assign,nonatomic) float stampDutyRateSeller;
@property (assign,nonatomic) float stampDutySeller;

//买方合计
@property (assign,nonatomic) float totalSeller;

//Seller 卖方
//buyer 买方
//卖方信息,
//卖方信息-增值税率
@property (assign,nonatomic) float addedValueTaxRateBuyer;
//卖方信息-增值税
@property (assign,nonatomic) float addedValueTaxBuyer;

//卖方信息-增值税率
@property (assign,nonatomic) float cityTaxRateBuyer;
//卖方信息-增值税
@property (assign,nonatomic) float cityTaxBuyer;

//卖方信息-教育税率
@property (assign,nonatomic) float eduTaxRateBuyer;
//卖方信息-教育税
@property (assign,nonatomic) float eduTaxBuyer;

//卖方信息-地方教育税率
@property (assign,nonatomic) float localEduTaxRateBuyer;
//卖方信息-地方教育税
@property (assign,nonatomic) float localEduTaxBuyer;

//卖方信息-印花税
@property (assign,nonatomic) float stampDutyRateBuyer;
@property (assign,nonatomic) float stampDutyBuyer;

//卖方信息-土地增值税
@property (assign,nonatomic) float addedLandRateBuyer;
@property (assign,nonatomic) float addedLandBuyer;

//卖方信息-土地增值税
@property (assign,nonatomic) float incomeRateBuyer;
@property (assign,nonatomic) float incomeLandBuyer;

//卖方合计
@property (assign,nonatomic) float totalBuyer;

//计算后数据
- (void)calTax;
//计算后数据
- (NSString *)formattedTaxResult;
//工具方法
+(NSString * ) convertFloatToString:(float)date;
//百分比
+(NSString * ) convertFloatToStringProc:(float)date;
+(float) convertStringToFloat:(NSString *)date;
+ (NSString *)currentDate;
@end
