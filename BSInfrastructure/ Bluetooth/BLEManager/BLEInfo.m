//
//  BLEInfo.m
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BLEInfo.h"

@implementation BLEInfo

@synthesize discoveredPeripheral;
@synthesize rssi;

-(void)dealloc{
    self.rssi=nil;
    //self.discoveredPeripheral=[CBPeripheral alloc];
}
-(void)realse{
    
    
}
@end
