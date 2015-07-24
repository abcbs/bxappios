//
//  BLEInfo.h
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEInfo : NSObject

@property (nonatomic, retain) CBPeripheral *discoveredPeripheral;
@property (nonatomic, assign) NSNumber *rssi;

@end
