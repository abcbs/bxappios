//
//  RemoteUserManager.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "RemoteUserManager.h"
#import "BSUIFrameworkHeader.h"

@implementation RemoteUserManager

static RemoteUserManager *instance;

+(UserManager *) remoteInstance{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

-(NSMutableArray *) loadLoginUser:(LoginUser *)user{
    BSLog(@"服务器方法，获取用户注册信息");
    return nil;
}
@end
