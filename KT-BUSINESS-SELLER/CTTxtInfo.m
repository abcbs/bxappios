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
}
@end
