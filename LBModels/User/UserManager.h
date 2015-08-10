//
//  UserManager.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUser.h"
#import "ErrorMessage.h"
#import "UserSession.h"

@interface UserManager : NSObject

+(UserManager *)userManager;

+(UserManager *) localUserManager;


+(void) registSession:(UserSession *)userSession;

+(BOOL)checkSession;

+(NSString *)currentSessionId;


#pragma mark -商家经营类型
-(NSMutableArray *) loadLoginUser:(LoginUser *)user;

-(NSMutableArray *) loadLoginUser:(LoginUser *)user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block; 

- (void)insertLoginUser:(LoginUser *) user;

-(void)insertLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;


-(void)updateLoginUser:(LoginUser *) user
                      atIndex:(NSInteger)index;

-(void)updateLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

-(void)removeLoginUser:(LoginUser *) user;

-(void)removeLoginUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

-(void)removeLoginUserWithIndex:(NSInteger) index;


#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
            blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

@end
