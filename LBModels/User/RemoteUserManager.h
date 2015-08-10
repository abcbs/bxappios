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

-(NSMutableArray *) loadLoginUser:(LoginUser *)user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

-(void)insertLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

-(void)updateLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;


-(void)removeLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
          blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;
@end
