//
//  KTHandyViewController.h
//  KTAPP
//
//  Created by admin on 15/6/21.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BSUITableViewInitRuntimeController.h"

@interface KTHandyViewController : BSUITableViewInitRuntimeController

- (IBAction)availBluetoothDevice:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *showSwitchValue;


@property (nonatomic, strong) CBPeripheralManager *manager;




@end
