//
//  RemoteUserManager.h
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserManager.h"
#import "Conf.h"

@interface RemoteUserManager : UserManager

+(UserManager *) remoteInstance;

-(NSMutableArray *) loadLoginUser:(LoginUser *)user  blockArray:(BSHTTPResponse)block;

-(void)insertLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block;

-(void)updateLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block;


-(void)removeLoginUser:(BSHTTPResponse)block;

#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
          blockArray:(BSHTTPResponse)block;
@end
