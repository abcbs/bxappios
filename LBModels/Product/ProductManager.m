//
//  ProductManager.m
//  KTAPP
//
//  Created by admin on 15/6/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductManager.h"

@implementation ProductManager

static ProductManager *instance;

+(ProductManager *)productManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

#pragma mark -经营类型信息管理
-(NSMutableArray *) loadProductCatalogue:(ProductCatalogue *)catalogue{
    NSString *path = [self pathForProductCatalogue];
    NSMutableArray * bpList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bpList) {
        return [NSMutableArray new];
    }
    return bpList;
}

- (void)insertProductCatalogue:(ProductCatalogue *) catalogue{
    NSMutableArray * bsList=[self localProductCatalogue ];
    [bsList addObject:catalogue];
    NSString *path = [self pathForProductCatalogue];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)updateProductCatalogue:(ProductCatalogue *) catalogue
                      atIndex:(NSInteger)index{

    NSMutableArray * bsList=[self localProductCatalogue ];
    if (index>0) {
        [bsList removeObjectAtIndex:index];
    }
    
    [bsList insertObject:catalogue atIndex:index];
    NSString *path = [self pathForProductCatalogue];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)removeProductCatalogue:(ProductCatalogue *) catalogue{
    NSMutableArray * bsList=[self localProductCatalogue ];
    NSString *path = [self pathForProductCatalogue];
    [bsList removeObject:catalogue];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}

-(void)removeProductCatalogueWithIndex:(NSInteger) index{
    NSMutableArray * bsList=[self localProductCatalogue ];
    NSString *path = [self pathForProductCatalogue];
    [bsList removeObjectAtIndex:index];
    [NSKeyedArchiver archiveRootObject:bsList toFile:path];
}


#pragma mark -从本地装载所有的数据
-(NSMutableArray *) localProductCatalogue{
    NSString *path = [self pathForProductCatalogue];
    NSMutableArray *bsList=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!bsList) {
        return [NSMutableArray new];
    }
    return bsList;
}

#pragma mark -从本地装载数据的路径
- (NSString *)pathForProductCatalogue
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"catalogue.plist"];
    
    return path;
}

@end
