//
//  BSSecurity.h
//  KTAPP
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSecurity : NSObject

+(BSSecurity *)sharedBSSecurity;

- (NSString *)encryptString:(NSString *)plainText;

- (NSData *)encryptData:(NSData *)data;

- (NSString *)decryptString:(NSString *)plainText;

- (NSData *)decryptData:(NSData *)plainData;

@end
