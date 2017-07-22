//
//  CTResultViewController.m
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CTResultViewController.h"

@implementation CTResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //买方信息-契税
    //买方信息-契税税率
    NSString * device=[Conf deviceMachine];
    if([device isEqualToString:@"iPhone 4S"]){
        self.contractTaxRateSellerLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxRateSellerTotalLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxRateNodeSellerLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutyRateSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutyRateNoteSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutySellerLabel.font = [UIFont systemFontOfSize:14];
        
        self.stampDutyRateNoteSellerLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerNoteLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerLabel.font = [UIFont systemFontOfSize:14];
        
        
        self.stampDutySellerNoteLabel.font = [UIFont systemFontOfSize:14];
        
        self.stampDutySellerLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerTotalLabel.font = [UIFont systemFontOfSize:14];
        
        self.addedValueTaxRateTotalBuyerLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxRateBuyerNoteLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxRateBuyerLabel.font = [UIFont systemFontOfSize:14];
        
        self.addedValueTaxNoteBuyerLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxBuyerLabel.font = [UIFont systemFontOfSize:14];

    }
    self.contractTaxRateSellerLabel.text=[CTTxtInfo
                                          convertFloatToStringProc:self.taxInfo.contractTaxRateSeller];
    self.contractTaxSellerLabel.text=[CTTxtInfo
                                       convertFloatToString:self.taxInfo.contractTaxSeller];
    //买方信息-印花税
    self.stampDutyRateSellerLabel.text=[CTTxtInfo
                                  convertFloatToStringProc:self.taxInfo.stampDutyRateSeller];

    self.stampDutySellerLabel.text=[CTTxtInfo
                              convertFloatToString:self.taxInfo.stampDutySeller];
    //卖方信息
    //卖方信息-增值税率
    self. addedValueTaxRateBuyerLabel.text=[CTTxtInfo
                                            convertFloatToStringProc:self.taxInfo.stampDutyRateSeller];

    
    self.addedValueTaxBuyerLabel.text=[CTTxtInfo
                                       convertFloatToString:self.taxInfo.stampDutyRateSeller];;
    
    //卖方信息-城建税
    self.cityTaxRateBuyerLabel.text=[CTTxtInfo
                                     convertFloatToStringProc:self.taxInfo.cityTaxRateBuyer];
;
    
    
    self.cityTaxBuyerLabel.text=[CTTxtInfo
                                 convertFloatToString:self.taxInfo.cityTaxBuyer];
    
    
    //卖方信息-教育税率
    self.eduTaxRateBuyerLabel.text=[CTTxtInfo
                                    convertFloatToStringProc:self.taxInfo.eduTaxRateBuyer];
;
    
    
    self.eduTaxBuyerLabel.text=[CTTxtInfo
                                convertFloatToString:self.taxInfo.eduTaxBuyer];
    
    //卖方信息-地方教育税率
    
    self.localEduTaxRateBuyerLabel.text=[CTTxtInfo
                                         convertFloatToStringProc:self.taxInfo.localEduTaxRateBuyer];
    
    self.localEduTaxBuyerLabel.text=[CTTxtInfo
                                     convertFloatToString:self.taxInfo.localEduTaxBuyer];
    
    //卖方信息-印花税
    self.stampDutyRateBuyerLabel.text=[CTTxtInfo
                                       convertFloatToStringProc:self.taxInfo.stampDutyRateBuyer];
    
    
    self.stampDutyBuyerLabel.text=[CTTxtInfo
                                   convertFloatToString:self.taxInfo.stampDutyBuyer];
    
    //卖方信息-土地增值税
    
    self.addedLandRateBuyerLabel.text=[CTTxtInfo
                                       convertFloatToStringProc:self.taxInfo.addedLandRateBuyer];

    
    self.addedLandBuyerLabel.text=[CTTxtInfo
                                   convertFloatToString:self.taxInfo.addedLandBuyer];
    
    //卖方信息-个人所得税
    self.incomeRateBuyerLabel.text=[CTTxtInfo
                                    convertFloatToStringProc:self.taxInfo.incomeRateBuyer];


    self.incomeLandBuyerLabel.text=[CTTxtInfo
                                    convertFloatToString:self.taxInfo.incomeLandBuyer];
    
    
}
@end
