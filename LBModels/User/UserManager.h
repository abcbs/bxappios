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
#import "Conf.h"

@interface UserManager : NSObject

+(UserManager *)userManager;

+(UserManager *) localUserManager;


+(void) registSession:(UserSession *)userSession;

+(BOOL)checkSession;

+(NSString *)currentSessionId;


#pragma mark -商家经营类型
-(NSMutableArray *) loadLoginUser:(LoginUser *)user;

-(NSMutableArray *) loadLoginUser:(LoginUser *)user
                       blockArray:(BSHTTPResponse)block;

- (void)insertLoginUser:(LoginUser *) user;

-(void)insertLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block;


-(void)updateLoginUser:(LoginUser *) user
                      atIndex:(NSInteger)index;

-(void)updateLoginUser:(LoginUser *) user atIndex:(NSInteger)index
            blockArray:(BSHTTPResponse)block;

-(void)removeLoginUser:(LoginUser *) user;

-(void)removeLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block;

-(void)removeLoginUserWithIndex:(NSInteger) index;


#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block;

@end
