//
//  LOProductCatalogueMaintainViewController.h
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "LOCatagoryManagerDelegate.h"
#import "LBModelsHeader.h"

@interface LOProductCatalogueMaintainViewController : BSUITableViewCommonController

//编辑代理
@property (nonatomic,weak) id<LOCatagoryManagerDelegate> editDelegate;

//业务类型
@property (nonatomic,strong) ProductCatalogue *productCatalogue;


@property (strong, nonatomic) IBOutlet UITextField *code;

@property (strong, nonatomic) IBOutlet UITextField *comment;

@property (strong, nonatomic) IBOutlet UITextField *statusValue;


- (IBAction)status:(id)sender;


- (IBAction)saveProduceCatalogue:(id)sender;

@end
