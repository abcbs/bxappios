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

- (IBAction)chooseHeaderImages:(id)sender;

- (IBAction)saveBLEInfo:(id)sender;

@end
