//
//  UserSession.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject


@property (retain,nonatomic) NSString * sessionId;

@property (retain,nonatomic) NSString * username;

@property (retain,nonatomic) NSString * status;

@end
