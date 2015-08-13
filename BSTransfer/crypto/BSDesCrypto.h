//
//  BSDesCrypto.h
//  WyCrypto
//
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonCryptor.h>
#import "Base64.h"


@interface BSDesCrypto : NSObject

- (NSString *) encrypt: (NSString *) text key:(NSString *) key;
- (NSString *) decrypt: (NSString *) text key:(NSString *) key;

@end
