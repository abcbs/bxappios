//
//  UserManager.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUser.h"

@interface UserManager : NSObject

+(UserManager *)userManager;

+(UserManager *) localUserManager;

#pragma mark -商家经营类型
-(NSMutableArray *) loadLoginUser:(LoginUser *)user;

- (void)insertLoginUser:(LoginUser *) user;

-(void)updateLoginUser:(LoginUser *) user
                      atIndex:(NSInteger)index;

-(void)removeLoginUser:(LoginUser *) user;

-(void)removeLoginUserWithIndex:(NSInteger) index;

@end
