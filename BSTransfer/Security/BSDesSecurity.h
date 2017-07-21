//
//  BSDesSecurity.h
//  KTAPP
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSSecurity.h"
#import "BSDesCrypto.h"

@interface BSDesSecurity : BSSecurity

@property (strong, nonatomic) BSDesCrypto *des;

+(BSSecurity *)sharedBSSecurity;

- (NSString *)encryptString:(NSString *)plainText;

- (NSString *)decryptString:(NSString *)encryptText;

@end
