//
//  UserManager.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

static UserManager *instance;

+(UserManager *)userManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

#pragma mark -商家经营类型

-(NSMutableArray *) loadLoginUser:(LoginUser *)user{
    NSString *path = [self pathForLoginUser];
    NSMutableArray * bpList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bpList) {
        return [NSMutableArray new];
    }
    return bpList;

}


- (void)insertLoginUser:(LoginUser *) user{
    NSMutableArray * bsList=[self localForLoginUser ];
    [bsList addObject:user];
    NSString *path = [self pathForLoginUser];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
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

@end
