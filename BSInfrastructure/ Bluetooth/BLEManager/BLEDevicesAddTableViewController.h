//
//  BLEDevicesAddTableViewController.h
//  KTAPP
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewCommonController.h"
#import "BSIFTTHeader.h"
#import "BLEDevicesTableViewController.h"
@interface BLEDevicesAddTableViewController : BSUITableViewCommonController

@property (weak, nonatomic) id<BLCentralExtention> bleInfoDelegate;


@property (weak, nonatomic) IBOutlet UITextField *bleName;

@property (weak, nonatomic) IBOutlet UIView *headImage;

@property (weak, nonatomic) IBOutlet UITextView *signName;

- (IBAction)chooseHeaderImages:(id)sender;

- (IBAction)saveBLEInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *detailInfoTextField;


- (IBAction)pickImags:(id)sender;

- (IBAction)previewImages:(id)sender;



@end
