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


//算税模型数据
@end
