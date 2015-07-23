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

#pragma mark 控制器业务实现与模型
//控制器业务实现代理
@property (weak, nonatomic) id<LSProductManagerDelegate> browseDelegate;

//产品模型
@property (strong, nonatomic) BusinessProduct *product;

//产品名称
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

#pragma mark -事件处理机制
//状态栏保存按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editedProduct;

//商品图像浏览事件
- (IBAction)previewHeadImage:(id)sender;
//轮播图预览
- (IBAction)previewResourceImages:(id)sender;



@end
