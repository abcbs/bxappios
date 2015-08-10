//
//  LOLoginUserDelegate.h
//  KTAPP
//  登陆信息维护
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBModelsHeader.h"

@protocol LOLoginUserDelegate <NSObject>

@optional

/**
 *新增
 */
- (void)addLoginUser:(LoginUser *) user;

- (void) addLoginUser:(LoginUser *) user
           blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;
/**
 *维护
 */
- (void)editedLoginUser:(LoginUser *) user;

- (void)editedLoginUser:(LoginUser *) user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

/**
 *装载初始化数据
 */
-(void) loadLoginUser:(LoginUser *) user;

-(void) loadLoginUser:(LoginUser *) user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

/**
 *装载初始化数据
 */
-(void) removeLoginUser:(LoginUser *) user;
-(void) removeLoginUser:(LoginUser *) user  blockArray:(void (^)(NSObject *response, NSError *error,ErrorMessage *errorMessage))block;

@end
