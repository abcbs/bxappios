//
//  CTMainViewController.h
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"

@interface CTMainViewController : BSUITableViewCommonController

//交易类型
@property (weak, nonatomic) IBOutlet UIPickerView *transactionTypePick;

//赠与关系
@property (weak, nonatomic) IBOutlet UIPickerView *giftRelationshipPick;

//房屋类型
@property (weak, nonatomic) IBOutlet UIPickerView *houseTypePick;

//买方住房记录类型
@property (weak, nonatomic) IBOutlet UIPickerView *buyerHistTypePick;

//卖方住房类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerHouseTypePick;

//卖方购房年限类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerFixedYearsTypePick;

//卖方购房记录类型
@property (weak, nonatomic) IBOutlet UIPickerView *sellerHouseRecordTypePick;

//个人所得税征收方式
@property (weak, nonatomic) IBOutlet UIPickerView *incomeTaxTypePick;

//土地增值税征收方式
@property (weak, nonatomic) IBOutlet UIPickerView *landTaxTypePick;
@end
