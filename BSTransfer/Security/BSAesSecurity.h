//
//  BSAesSecurity.h
//  KTAPP
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSSecurity.h"

@interface BSAesSecurity : BSSecurity

+(BSSecurity *)sharedBSSecurity;

- (NSString *)encryptString:(NSString *)plainText;

- (NSString *)decryptString:(NSString *)encryptText;


@end
