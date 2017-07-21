//
//  BSSecurity.h
//  KTAPP
//  缺省使用RSA方式
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSecurity : NSObject

+(BSSecurity *)sharedBSSecurity;

- (NSString *)encryptString:(NSString *)plainText;

- (NSString *)decryptString:(NSString *)encryptText;

//- (NSData *)decryptData:(NSData *)plainData;
//- (NSData *)encryptData:(NSData *)data;
@end
