//
//  UserManager.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserManager.h"
#import "BSUIFrameworkHeader.h"
#import "RemoteUserManager.h"
#import "UserSession.h"

static const char *const kDataLocalOperationQueueName = "kDataLocalOperationQueue";

@interface UserManager(){
    
     dispatch_queue_t _queue;
}
@end

@implementation UserManager

static UserManager *instance;

static UserSession *session;

+(UserManager *)userManager{
    if (DATA_IS_LOCAL) {
      
        return [self localUserManager];
    }else{
       return  [RemoteUserManager remoteInstance];
    }
    
}

+(UserManager *) localUserManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
        
    }
    return instance;
}
- (instancetype)init {
    if ((self = [super init]) != nil) {
        _queue =
        dispatch_queue_create(kDataLocalOperationQueueName, NULL);
    }
    return self;
}

+(void) registSession:(UserSession *)userSession{
    if (!session) {
        session=[UserSession new];
        
    }
    session.username=userSession.username;
    session.sessionId=userSession.sessionId;
    session.status=userSession.status;
}

+(NSString *)currentSessionId{
    return session.sessionId;
}

+(BOOL)checkSession{
    if (!DEFAULT_ROLE) {
        return YES;
    }
    if (!session) {
        return NO;
    }
    if (!session.sessionId) {
        return NO;
    }
    if (![session.status isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}
#pragma mark -商家经营类型

-(NSMutableArray *) loadLoginUser:(LoginUser *)user  blockArray:(BSHTTPResponse)block{
    [self loadLoginUser:user];
    if (block) {
        block(nil,nil,nil);
        
    }
    return [self loadLoginUser:user];
}

-(NSMutableArray *) loadLoginUser:(LoginUser *)user{
    NSString *path = [self pathForLoginUser];
    NSMutableArray * bpList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bpList) {
        return [NSMutableArray new];
    }
    return bpList;

}
//本地适配远程方法
-(void)insertLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block{
    
    dispatch_async(_queue, ^{
        [self insertLoginUser:user];
    });
    if (block) {
        block(nil,nil,nil);
        
    }
    
}
- (void)insertLoginUser:(LoginUser *) user{
    NSMutableArray * bsList=[self localForLoginUser ];
    [bsList addObject:user];
    NSString *path = [self pathForLoginUser];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)updateLoginUser:(LoginUser *) user atIndex:(NSInteger)index
            blockArray:(BSHTTPResponse)block{
     dispatch_async(_queue, ^{
         [self updateLoginUser:user atIndex:index];
     });
    if (block) {
        block(nil,nil,nil);
        
    }
    
}

-(void)updateLoginUser:(LoginUser *) user
               atIndex:(NSInteger)index{
    NSMutableArray * bsList=[self localForLoginUser ];
    if (index>0) {
        [bsList removeObjectAtIndex:index];
    }
    
    [bsList insertObject:user atIndex:index];
    NSString *path = [self pathForLoginUser];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}


-(void)removeLoginUser:(LoginUser *) user
            blockArray:(BSHTTPResponse)block{
    [self removeLoginUser:user];
}

-(void)removeLoginUser:(LoginUser *) user{
    NSMutableArray * bsList=[self localForLoginUser ];
    NSString *path = [self pathForLoginUser];
    [bsList removeObject:user];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];

}

-(void)removeLoginUserWithIndex:(NSInteger) index{
    NSMutableArray * bsList=[self localForLoginUser ];
    NSString *path = [self pathForLoginUser];
    [bsList removeObjectAtIndex:index];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

#pragma mark -从本地装载所有的数据
-(NSMutableArray *) localForLoginUser{
    NSString *path = [self pathForLoginUser];
    NSMutableArray *bsList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bsList) {
        return [NSMutableArray new];
    }
    return bsList;
}

#pragma mark -从本地装载数据的路径
- (NSString *)pathForLoginUser
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"loginuser.plist"];
    
    return path;
}


#pragma mark -登陆方法
-(void)loginWithUser:(LoginUser *) user
          blockArray:(BSHTTPResponse)block{
    BSLog(@"loginWithUser");
}
@end
