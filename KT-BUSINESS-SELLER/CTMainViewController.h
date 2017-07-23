//
//  CTMainViewController.h
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "CTManagerDelegate.h"
#import "CTTxtInfo.h"

@interface CTMainViewController : BSUITableViewCommonController<CTManagerDelegate>


//0-交易类型
@property (weak, nonatomic) IBOutlet UIPickerView *transactionTypePick;

//1-赠与关系
@property (weak, nonatomic) IBOutlet UIPickerView *giftRelationshipPick;

@property (weak, nonatomic) IBOutlet UILabel *giftRelationshipLabel;

//2-房屋类型
@property (weak, nonatomic) IBOutlet UIPickerView *houseTypePick;

//3-买方住房记录类型
@property (weak, nonatomic) IBOutlet UIPickerView *buyerHistTypePick;

//4-卖方住房类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerHouseTypePick;

//5-卖方购房年限类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerFixedYearsTypePick;

//6-卖方购房记录类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerHouseRecordTypePick;

//7-个人所得税征收方式
@property (weak, nonatomic) IBOutlet UIPickerView *incomeTaxTypePick;

//8-土地增值税征收方式
@property (weak, nonatomic) IBOutlet UIPickerView *landTaxTypePick;


//算税模型数据-输入框
//建筑面积
@property (weak, nonatomic) IBOutlet UITextField *builtAreaTextField;

//网签价格
@property (weak, nonatomic) IBOutlet UITextField *onlineSignedPriceTextField;

//核定价格
@property (weak, nonatomic) IBOutlet UITextField *approvedPriceTextField;


////////////////////
//房屋原始价格
@property (weak, nonatomic) IBOutlet UITextField *houseRawPriceTextField;


//房屋原始契税
@property (weak, nonatomic) IBOutlet UITextField *contractRawTaxTextField;

//装修费用
@property (weak, nonatomic) IBOutlet UITextField *renovationFaxTextField;

//贷款利息
@property (weak, nonatomic) IBOutlet UITextField *loanInterestTextField;


//房屋原始价格-土地增值税
@property (weak, nonatomic) IBOutlet UITextField *houseRawPriceLandTextField;

//房屋原始契税-土地增值税
@property (weak, nonatomic) IBOutlet UITextField *contractRawTaxLandTextField;

//发票年限
@property (weak, nonatomic) IBOutlet UITextField *invoicesYearLimitTextField;

@end
