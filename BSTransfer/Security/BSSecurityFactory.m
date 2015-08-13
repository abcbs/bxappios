//
//  BSSecurityFactory.m
//  KTAPP
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSSecurityFactory.h"
#import "BSSecurity.h"
#import "BSDesSecurity.h"

@implementation BSSecurityFactory

+(BSSecurity *)initBSecurity{
    return [BSSecurityFactory initBSecurity:BSEncryptionAlgorithmRSA];
}

+(BSSecurity *)initBSecurity:(BSEncryptionAlgorithm) algorithm{
    BSSecurity *instance;
    switch (algorithm) {
        case BSEncryptionAlgorithmRSA:
            instance= [BSSecurity sharedBSSecurity];
            break;
        case BSEncryptionAlgorithmDES:
            instance= [BSDesSecurity sharedBSSecurity];
            break;
        default:
            instance= [BSSecurity sharedBSSecurity];
            break;
    }
    return instance;
}
@end
