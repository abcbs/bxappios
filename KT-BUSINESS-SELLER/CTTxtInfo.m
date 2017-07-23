//
//  CTTxtInfo.m
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CTTxtInfo.h"

@implementation CTTxtInfo

static CTTxtInfo *instance=nil;

+(CTTxtInfo *)calTaxInfo{
    if (!instance) {
        
        instance=[[super allocWithZone:nil]init];
    }
       return instance;
}

+(NSArray *) transactionTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"买卖",@"赠与", nil];
}

//1-赠与类型
+(NSArray *) giftRelationshipData{
    return [[NSArray alloc]initWithObjects:@"",@"亲属关系",@"非亲属关系", nil];
}
//2-房屋类型
+(NSArray *) houseTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"住房",@"非住房", nil];
}
//3-买方住房记录类型
+(NSArray *) buyerHistTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"家庭唯一住房",@"非家庭唯一住房", nil];
}
//4-卖方住房类型
+(NSArray *) sellerHouseTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"普通住房",@"非普通住房", nil];

}
//5-卖方购房年限类型
+(NSArray *) sellerFixedYearsTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"不满两年",@"满两年不满五年",@"已满五年", nil];

}
//6-卖方购房记录类型
+(NSArray *) sellerHouseRecordTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"家庭唯一住房",@"非家庭唯一住房", nil];
}
//7-个人所得税征收方式
+(NSArray *) incomeTaxTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"核定征收",@"据实征收", @"满五年家庭唯一住房免税",nil];

}
//8-土地增值税征收方式
+(NSArray *) landTaxTypeData{
    return [[NSArray alloc]initWithObjects:@"",@"核定征收",@"据实征收", @"个人住房免税",nil];
}

//0-交易类型
+(NSInteger) transactionType{
    return 0;
}
//1-赠与类型
+(NSInteger) giftRelationshipType{
    return 1;
}
//2-房屋类型
+(NSInteger) houseType{
    return 2;
}
//3-买方住房记录类型
+(NSInteger) buyerHistType{
    return 3;
}
//4-卖方住房类型;
+(NSInteger) sellerHouseType{
    return 4;
}
//5-卖方购房年限类型
+(NSInteger) sellerFixedYearsType{
    return 5;
}
//6-卖方购房记录类型
+(NSInteger) sellerHouseRecordType{
    return 6;
}
//7-个人所得税征收方式
+(NSInteger) incomeTaxType{
    return 7;
}
//8-土地增值税征收方式
+(NSInteger) landTaxType{
    return 8;
}

+transactionTypeContent{
    return @"赠与";
}
+(NSString *) incomeTaxTypeFactsContent{
    return @"据实征收";
}


+(NSString *)landTaxTypeFactsContent{
    return @"据实征收";
}


+(NSString * ) convertFloatToString:(float)date{
    return [NSString stringWithFormat:@"%.2f", date];
}

+(NSString * ) convertFloatToStringProc:(float)date{
     return [NSString stringWithFormat:@"%.1f%%", date];
}

// float floatString = [newString floatValue];
+(float) convertStringToFloat:(NSString *)date{
     return [date floatValue];
}

- (void)calTax{
    //买方信息-契税
    
    //买方信息-契税税率
    self.contractTaxRateSeller=3;
    self.contractTaxSeller=100.00;
    
    //买方信息-印花税
    self.stampDutyRateSeller=0.05;
    self.stampDutySeller=1.00;
    
    //买方合计
    self.totalSeller=101.00;
    
    //卖方合计
    self.totalBuyer=11.90;
}

- (NSString *)formattedTaxResult{
    //0-交易类型
    NSString * result=[NSString stringWithFormat:@"交易类型:%@", self.transactionTypeCurrent];
    //1-赠与类型 交易类型为赠与，赠与选项
    if([self.transactionTypeCurrent isEqualToString:[CTTxtInfo transactionTypeContent]]){
        result=[result stringByAppendingFormat:@"赠与关系:%@",self.giftRelationshipCurrent];
    }
    result=[result stringByAppendingFormat:@"\n"];
    //2-房屋类型
    result=[result stringByAppendingFormat:@"房屋类型:%@",self.houseTypeCurrent];
    
    result=[result stringByAppendingFormat:@"建筑面积:%.2f平方米",self.houseBuiltArea];
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"网签价格:%.2f元",self.onlineSignedPrice];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"核定价格:%.2f元",self.approvedPrice];
    result=[result stringByAppendingFormat:@"\n"];
    
    //3-买方住房记录类型
    result=[result stringByAppendingFormat:@"买方住房记录类型:%@",self.buyerHistTypeCurrent];
    result=[result stringByAppendingFormat:@"\t"];
    //4-卖方住房类型;
    result=[result stringByAppendingFormat:@"卖方住房类型%@",self.sellerHouseTypeCurrent];
    result=[result stringByAppendingFormat:@"\n"];
    //5-卖方购房年限类型
    result=[result stringByAppendingFormat:@"卖方购房年限类型%@", self.sellerFixedYearsTypeCurrent];
    result=[result stringByAppendingFormat:@"\t"];
    //6-卖方购房记录类型
    result=[result stringByAppendingFormat:@"卖方购房记录类型%@", self.sellerHouseRecordTypeCurrent];
    result=[result stringByAppendingFormat:@"\n"];
    
    //7-个人所得税征收方式
    result=[result stringByAppendingFormat:@"个人所得税征收方式%@", self.incomeTaxTypeCurrent];
    result=[result stringByAppendingFormat:@"\t"];
    //个人所得税征收方式-据实征收
    if([self.incomeTaxTypeCurrent isEqualToString:[CTTxtInfo incomeTaxTypeFactsContent]]){
        result=[result stringByAppendingFormat:@"房屋原始价格:%.2f元",self.houseRawPrice];
        result=[result stringByAppendingFormat:@"\t"];
        //
        result=[result stringByAppendingFormat:@"房屋原始契税:%.2f元",self.contractRawTax];
        result=[result stringByAppendingFormat:@"\t"];
        //
        result=[result stringByAppendingFormat:@"\n"];
        result=[result stringByAppendingFormat:@"装修费用:%.2f元",self.renovationFax];
        result=[result stringByAppendingFormat:@"\t"];
        //
        result=[result stringByAppendingFormat:@"贷款利息:%.2f元",self.loanInterest];
        result=[result stringByAppendingFormat:@"\n"];
    }

    
    result=[result stringByAppendingFormat:@"\n"];
    //8-土地增值税征收方式
    result=[result stringByAppendingFormat:@"土地增值税征收方式%@", self.landTaxTypeCurrent];
    result=[result stringByAppendingFormat:@"\n"];
    if([self.landTaxTypeCurrent isEqualToString:[CTTxtInfo landTaxTypeFactsContent]]){
        //房屋原始价格-土地增值税
        result=[result stringByAppendingFormat:@"房屋原始价格:%.2f元",self.houseRawPriceLand];
        result=[result stringByAppendingFormat:@"\t"];
        //房屋原始契税-土地增值税
        result=[result stringByAppendingFormat:@"房屋原始契税:%.2f元",self.contractRawTaxLand];
        result=[result stringByAppendingFormat:@"\t"];
        //发票年限
        result=[result stringByAppendingFormat:@"发票年限:%.1f年",self.invoicesYearLimit];
    }
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"计算结果"];
    result=[result stringByAppendingFormat:@"\n"];
    //买方
    result=[result stringByAppendingFormat:@"买方:"];
    result=[result stringByAppendingFormat:@"\n"];
    //买方信息-契税
    result=[result stringByAppendingFormat:@"契税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                          convertFloatToStringProc:self.contractTaxRateSeller]];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳契税:%@元",[CTTxtInfo
                                      convertFloatToString:self.contractTaxSeller]];
    
    result=[result stringByAppendingFormat:@"\n"];
    //买方信息-印花税
    result=[result stringByAppendingFormat:@"印花税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                        convertFloatToStringProc:self.stampDutyRateSeller]];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳印花税:%@元",[CTTxtInfo
                                    convertFloatToString:self.stampDutySeller]];
    
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"买方（转入方）各项应纳税款总计:%@元",[CTTxtInfo
                                                        convertFloatToString:self.totalSeller]];
    result=[result stringByAppendingFormat:@"\n"];
    
    //卖方-buyer
    result=[result stringByAppendingFormat:@"卖方:"];
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"增值税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                                       convertFloatToStringProc:self.addedValueTaxRateBuyer]];
     result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳增值税:%@元",[CTTxtInfo
                                                        convertFloatToString:self.addedValueTaxBuyer]];
    result=[result stringByAppendingFormat:@"\n"];
    
    
    //卖方信息-城建税
    result=[result stringByAppendingFormat:@"城建税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                     convertFloatToStringProc:self.cityTaxRateBuyer]];
    
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳城建税:%@元",[CTTxtInfo
                                 convertFloatToString:self.cityTaxBuyer]];
    

    //卖方信息-教育税率
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"教育附加:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                    convertFloatToStringProc:self.eduTaxRateBuyer]];
    
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"教育附加费:%@元",[CTTxtInfo
                                convertFloatToString:self.eduTaxBuyer]];
    

    //卖方信息-地方教育税率
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"地方教育附加:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                         convertFloatToStringProc:self.localEduTaxRateBuyer]];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳教育附加费:%@元",[CTTxtInfo
                                     convertFloatToString:self.localEduTaxBuyer]];
    
    //卖方信息-印花税
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"印花税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                       convertFloatToStringProc:self.stampDutyRateBuyer]];
    
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳印花税:%@元",[CTTxtInfo
                                   convertFloatToString:self.stampDutyBuyer]];
    
    //卖方信息-土地增值税
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"土地增值税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                       convertFloatToStringProc:self.addedLandRateBuyer]];
    
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳土地增值税:%@元",[CTTxtInfo
                                   convertFloatToString:self.addedLandBuyer]];
    
    //卖方信息-个人所得税
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"个人所得税:"];
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"适用税率:%@",[CTTxtInfo
                                    convertFloatToStringProc:self.incomeRateBuyer]];
    
    result=[result stringByAppendingFormat:@"\t"];
    result=[result stringByAppendingFormat:@"应纳个人所得税:%@元",[CTTxtInfo
                                    convertFloatToString:self.incomeLandBuyer]];
    
    result=[result stringByAppendingFormat:@"\n"];
    result=[result stringByAppendingFormat:@"卖方（转出方）各项应纳税款总计:%@元",[CTTxtInfo
                                                                   convertFloatToString:self.totalBuyer]];
    return result;
}

+ (NSString *)currentDate
{
    NSDate *date = [NSDate date];
    // 2013-04-07 11:14:45
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // HH是24进制，hh是12进制
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *datestring = [formatter stringFromDate:date];
    return datestring;
}
@end
