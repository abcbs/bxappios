//
//  BSAesSecurity.m
//  KTAPP
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSAesSecurity.h"
#import "BSRSACrypto.h"
#import "NSData+CommonCrypto.h"
#import "Base64.h"

#define message @"KingTeller20150808"
@implementation BSAesSecurity

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -单例与实例化
+ (BSAesSecurity *)sharedBSSecurity {
    static BSAesSecurity *_singleton;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _singleton = [[super alloc] init];
    });
    
    return _singleton;
}

- (NSString *)encryptString:(NSString *)plainText{
    NSData *encryptedData = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[message dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *base64EncodedString = [encryptedData base64EncodedString];
    return base64EncodedString;
    
}

- (NSString *)decryptString:(NSString *)encryptText{
    if (![encryptText isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSData *encryptedData = [encryptText  base64DecodedData];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[message dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *str=[[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return str;

}
@end
