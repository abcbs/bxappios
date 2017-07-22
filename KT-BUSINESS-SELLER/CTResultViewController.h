//
//  CTResultViewController.h
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "CTManagerDelegate.h"
#import "CTTxtInfo.h"
@interface CTResultViewController : BSUITableViewCommonController

//业务模型和操作代理
@property (weak, nonatomic) id<CTManagerDelegate> resultDelegate;

//算税模型
@property (strong,nonatomic) CTTxtInfo * taxInfo;

//买方信息-契税
//买方信息-契税税率
@property (weak, nonatomic) IBOutlet UILabel *contractTaxRateSellerLabel;

@property (weak, nonatomic) IBOutlet UILabel *contractTaxRateSellerTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *contractTaxRateNodeSellerLabel;

@property (weak, nonatomic) IBOutlet UILabel *contractTaxSellerLabel;

//买方信息-印花税
@property (weak, nonatomic) IBOutlet UILabel *stampDutyRateNoteSellerLabel;

@property (weak, nonatomic) IBOutlet UILabel *stampDutyRateSellerNoteLabel;

@property (weak, nonatomic) IBOutlet UILabel *stampDutyRateSellerLabel;


@property (weak, nonatomic) IBOutlet UILabel *stampDutySellerNoteLabel;

@property (weak, nonatomic) IBOutlet UILabel *stampDutySellerLabel;

@property (weak, nonatomic) IBOutlet UILabel *stampDutyRateSellerTotalLabel;


//卖方信息

//卖方信息-增值税率
@property (weak, nonatomic) IBOutlet UILabel *addedValueTaxRateTotalBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *addedValueTaxRateBuyerNoteLabel;

@property (weak, nonatomic) IBOutlet UILabel *addedValueTaxRateBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *addedValueTaxNoteBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *addedValueTaxBuyerLabel;

//卖方信息-城建税
@property (weak, nonatomic) IBOutlet UILabel *cityTaxRateBuyerLabel;


@property (weak, nonatomic) IBOutlet UILabel *cityTaxBuyerLabel;


//卖方信息-教育税率
@property (weak, nonatomic) IBOutlet UILabel *eduTaxRateBuyerLabel;


@property (weak, nonatomic) IBOutlet UILabel *eduTaxBuyerLabel;

//卖方信息-地方教育税率
@property (weak, nonatomic) IBOutlet UILabel *localEduTaxRateNoteBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *localEduTaxNoteBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *localEduTaxRateBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *localEduTaxBuyerLabel;

//卖方信息-印花税
@property (weak, nonatomic) IBOutlet UILabel *stampDutyRateBuyerLabel;


@property (weak, nonatomic) IBOutlet UILabel *stampDutyBuyerLabel;

//卖方信息-土地增值税

@property (weak, nonatomic) IBOutlet UILabel *addedLandRateBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *addedLandBuyerLabel;

//卖方信息-个人所得税
@property (weak, nonatomic) IBOutlet UILabel *incomeRateBuyerLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeLandBuyerLabel;


@end
