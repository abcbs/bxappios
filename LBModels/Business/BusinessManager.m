//
//  BusinessManager.m
//  KTAPP
//
//  Created by admin on 15/6/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BusinessManager.h"
#import "LBModelsHeader.h"

@implementation BusinessManager
static BusinessManager *instance=nil;

+(BusinessManager *)businessManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

#pragma mark -商家数据维护
-(NSMutableArray *) loadBusiness:(BusinessBaseDomail *)business{
    NSString *path = [self loadForBusinessList];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


- (NSString *)loadForBusinessList
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"business.plist"];
    
    return path;
}

//更新数据
-(void)updateBusiness:(BusinessBaseDomail *)business atIndex:(NSInteger)index{
    NSMutableArray * bsList=[self localBusiness ];
    [bsList removeObjectAtIndex:index];
    [bsList insertObject:business atIndex:index];
     NSString *path = [self loadForBusinessList];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

//装载数据
-(NSMutableArray *) localBusiness{
    NSString *path = [self loadForBusinessList];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

//插入数据
-(void)insertBusiness:(BusinessBaseDomail *)business{
    NSMutableArray * bsList=[self localBusiness ];
    NSString *path = [self loadForBusinessList];
    if (![bsList containsObject:business]) {
        [bsList addObject:business];
    }

    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)removeBusiness:(BusinessBaseDomail *)business{
    NSMutableArray * bsList=[self localBusiness ];
    NSString *path = [self loadForBusinessList];
    [bsList removeObject:business];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

#pragma mark -商家商品数据维护
/**
 *装载初始化数据
 */
-(NSMutableArray *) loadBusinessProduct:(BusinessProduct *)product{
    NSString *path = [self loadForProductList];
    NSMutableArray * bpList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bpList) {
        return [NSMutableArray new];
    }
    return bpList;
    
}

#pragma mark --从本地装载数据
- (NSString *)loadForProductList
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"product.plist"];
    
    return path;
}

-(NSMutableArray *) localBusinessProduct{
    NSString *path = [self loadForProductList];
    NSMutableArray *bsList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bsList) {
        return [NSMutableArray new];
    }
    return bsList;
}

- (void)insertBusinessProduct:(BusinessProduct *) product{
    NSMutableArray * bsList=[self localBusinessProduct ];
    [bsList addObject:product];
    NSString *path = [self loadForProductList];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)updateBusinessProduct:(BusinessProduct *) product
                     atIndex:(NSInteger)index{
    NSMutableArray * bsList=[self localBusinessProduct ];
    if (index>0) {
        [bsList removeObjectAtIndex:index];
    }
    
    [bsList insertObject:product atIndex:index];
    NSString *path = [self loadForProductList];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
    
}

-(void)removeBusinessProduct:(BusinessProduct *) product{
    NSMutableArray * bsList=[self localBusinessProduct ];
    [bsList removeObject:product];
    NSString *path = [self loadForProductList];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}
@end
