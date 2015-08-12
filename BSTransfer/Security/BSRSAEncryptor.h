#import <Foundation/Foundation.h>

@interface BSRSAEncryptor : NSObject

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

+ (NSData *)encryptData:(NSData *)data publicSecKeyRef:(SecKeyRef )keyRef;
+ (NSString *)encryptString:(NSString *)str publicSecKeyRef:(SecKeyRef )keyRef;

+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

+ (NSData *)decryptData:(NSData *)data publicSecKeyRef:(SecKeyRef) keyRef;
+ (NSString *)decryptString:(NSString *)str publicSecKeyRef:(SecKeyRef) keyRef;


@end
