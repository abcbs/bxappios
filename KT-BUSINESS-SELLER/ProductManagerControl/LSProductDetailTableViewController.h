//
//  LSProductDetailTableViewController.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIFrameworkHeader.h"
#import "LBModelsHeader.h"
#import "LSProductManagerDelegate.h"

@interface LSProductDetailTableViewController :
BSUITableViewCommonController<LSProductManagerDelegate>

@property (weak, nonatomic) id<LSProductManagerDelegate> browseDelegate;

@property (strong, nonatomic) BusinessProduct *product;


@property (weak, nonatomic) IBOutlet UITextField *productName;


//优惠价格,卡价格
@property (weak, nonatomic) IBOutlet UITextField *preferPrice;

//促销价格
@property (weak, nonatomic) IBOutlet UITextField *salePrice;

//发布时间
@property (weak, nonatomic) IBOutlet UITextField *publishTime;

//商品种类
@property (weak, nonatomic) IBOutlet UITextField *productCatalogue;

//商品头像
@property (weak, nonatomic) IBOutlet UIView *headImage;

//商品介绍组图
@property (weak, nonatomic) IBOutlet UIView *resourceImags;

//商品宣传，介绍
@property (weak, nonatomic) IBOutlet UITextView *introduce;

//商品规格
@property (weak, nonatomic) IBOutlet UITextView *specification;

//商品介绍，备注
@property (weak, nonatomic) IBOutlet UITextView *comment;

//促销开始时间
@property (weak, nonatomic) IBOutlet UITextField *saleStartTime;

//促销结束时间
@property (weak, nonatomic) IBOutlet UITextField *saleOverTime;

//是否在售，上下架
@property (weak, nonatomic) IBOutlet UITextField *isSale;

//是否促销
@property (weak, nonatomic) IBOutlet UITextField *onSale;

//存量
@property (weak, nonatomic) IBOutlet UITextField *numbers;

//事件处理

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editedProduct;

@end
