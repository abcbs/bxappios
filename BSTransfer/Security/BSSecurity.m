//
//  BSSecurity.m
//  KTAPP
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSSecurity.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import "BSIFTTHeader.h"
#import "BSRSACrypto.h"
#import "Base64.h"

@interface BSSecurity (){
 }
@property(nonatomic,strong)BSRSACrypto *securityBSRSACrypto;

@end

@implementation BSSecurity
@synthesize securityBSRSACrypto;
static BSSecurity *instance;

#pragma mark -单例与实例化
+(BSSecurity *)sharedBSSecurity{
    if (!instance) {
        instance=[[super allocWithZone:NULL] init];
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedBSSecurity];
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark -解析文件
-(BSRSACrypto *)securityBSRSACrypto{
    if (!securityBSRSACrypto) {
    
        NSString *pkcsPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
        // 下面的与上面的一样
        //	NSString *pkcsPath = [[NSBundle mainBundle] pathForResource:@"pkcs-daniate" ofType:@"pfx"];
        NSString *certPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
        securityBSRSACrypto = [BSRSACrypto sharedBSRSACrypto];
    
        OSStatus status = -1;
        // 取得私钥，文件保护密码为KingTeller
        status = [securityBSRSACrypto extractEveryThingFromPKCS12File:pkcsPath passphrase:@"KingTeller"];
        BSLog(@"status = %d", (int)status);
        // 取得公钥
        status = [securityBSRSACrypto
                  extractPublicKeyFromCertificateFile:certPath  ];
        BSLog(@"status = %d", (int)status);
    }
    return securityBSRSACrypto;
}
- (NSData *)encryptData:(NSData *)data{
    return [self.securityBSRSACrypto encryptWithPublicKey:data];
}
//加密
- (NSString *)encryptString:(NSString *)plainText{
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [self.securityBSRSACrypto encryptWithPublicKey:plainData];
    return [encryptData base64EncodedString];
}

#pragma mark -解密,解密使用

- (NSData *)decryptData:(NSData *)plainData{
    
    return [self.securityBSRSACrypto decryptWithPrivateKey:plainData];;
}
- (NSString *)decryptString:(NSString *)plainText{
    NSData *data = [plainText base64DecodedData];

    NSData *decrypted = [self decryptData:data];

    return [[NSString alloc] initWithData:decrypted
                                 encoding:NSUTF8StringEncoding];

}

@end
