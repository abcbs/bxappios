//
//  RemoteUserManager.m
//  KTAPP
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "RemoteUserManager.h"
#import "BSHTTPNetworking.h"
#import "BSCMFrameworkHeader.h"
@implementation RemoteUserManager

static RemoteUserManager *instance;

+(UserManager *) remoteInstance{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

-(void)insertLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:user.realName,@"name",user.address,@"address",user.phoneNum,@"phone",nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:user.sex,@"sex",nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:user.userName,@"username",user.passWord,@"password",user.commitCode,@"confirmPassword",nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dic1,@"userBase",dic2,@"userDetailed",dic3,@"loginUser", nil];
    
    [BSHTTPNetworking httpPOST:USER_REGISTER_SCHEMA
                   pathPattern:USER_REGISTER_SCHEMA
                    parameters:dic
                    modelClass:[NSString class]
                       keyPath:@""
                         block:(BSHTTPResponse)block
     ];
    
}

-(NSMutableArray *) loadLoginUser:(LoginUser *)user
                       blockArray:(BSHTTPResponse)block{
    return nil;
}

-(void)updateLoginUser:(LoginUser *) user atIndex:(NSInteger)index
            blockArray:(BSHTTPResponse)block{
     BSLog(@"更新登陆数据");
}


-(void)removeLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block{
    BSLog(@"删除登陆数据");
}

-(void)removeLoginUser:(LoginUser *) user{
    BSLog(@"删除登陆数据");
}

#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
          blockArray:(BSHTTPResponse)block{
    
      NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.userName,@"username",user.passWord,@"password", nil];
    
    [BSHTTPNetworking httpPOST:USER_LOGIN_SCHEMA
                   pathPattern:USER_LOGIN_SCHEMA
                    parameters:dic
                    modelClass:[UserSession class]
                       keyPath:@""
                         block:(BSHTTPResponse)block
     ];

}

@end
