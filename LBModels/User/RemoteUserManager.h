//
//  RemoteUserManager.h
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserManager.h"

@interface RemoteUserManager : UserManager

+(UserManager *) remoteInstance;

@end
