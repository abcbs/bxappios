//
//  BSSecurityFactory.h
//  KTAPP
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSSecurity.h"
#import "BSDesSecurity.h"

@interface BSSecurityFactory : NSObject

typedef NS_ENUM(NSInteger, BSEncryptionAlgorithm)  {
    BSEncryptionAlgorithmRSA=0,
    BSEncryptionAlgorithmDES=1,
    BSEncryptionAlgorithmAES=2
} ;

+(BSSecurity *)initBSecurity;

+(BSSecurity *)initBSecurity:(BSEncryptionAlgorithm) algorithm;

@end
