//
//  NSObject+BSSecurity.h
//  KTAPP
//
//  Created by admin on 15/9/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "MJConst.h"
#import <CoreData/CoreData.h>
#import "MJProperty.h"

@interface NSObject (BSSecurity)

- (id)decrypt;
- (id) encrypt;
@end
