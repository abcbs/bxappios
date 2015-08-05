//
//  ProductManager.h
//  KTAPP
//
//  Created by admin on 15/6/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductCatalogue.h"

@interface ProductManager : NSObject

+(ProductManager *)productManager;


#pragma mark -商家经营类型
-(NSMutableArray *) loadProductCatalogue:(ProductCatalogue *)catalogue;

- (void)insertProductCatalogue:(ProductCatalogue *) catalogue;

-(void)updateProductCatalogue:(ProductCatalogue *) catalogue
                     atIndex:(NSInteger)index;

-(void)removeProductCatalogue:(ProductCatalogue *) catalogue;

-(void)removeProductCatalogueWithIndex:(NSInteger) index;

@end
