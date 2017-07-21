//
//  LOProductCatalogueDetailViewController.h
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOProductCatalogueMaintainViewController.h"
#import "LOCatagoryManagerDelegate.h"
#import "LBModelsHeader.h"

@interface LOProductCatalogueDetailViewController : LOProductCatalogueMaintainViewController<LOCatagoryManagerDelegate>


//查看代理
@property (nonatomic,weak) id<LOCatagoryManagerDelegate> browseDelegate;

//业务类型
@property (nonatomic,strong) ProductCatalogue *productCatalogue;

//代码
@property (strong, nonatomic) IBOutlet UITextField *code;

//备注
@property (strong, nonatomic) IBOutlet UITextField *comment;

//状态值
@property (strong, nonatomic) IBOutlet UITextField *statusValue;

@end
