//
//  KTHandyViewController.h
//  KTAPP
//
//  Created by admin on 15/6/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface KTHandyViewController : UIViewController

- (IBAction)availBluetoothDevice:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *showSwitchValue;


@property (nonatomic, strong) CBPeripheralManager *manager;

@end
