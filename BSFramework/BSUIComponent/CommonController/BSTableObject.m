//
//  BSTableObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableObject.h"
#import "BSTableContentObject.h"

@implementation BSTableObject

@synthesize header;
@synthesize vcClass;
@synthesize content;

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                      vcClass:(Class)vcClass
                                    bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header vcClass:vcClass bsContentArray:bsContents];
}

+(instancetype) initWithHeaderVcClassFirstContent:(NSString *)header
                                          vcClass:(Class)vcClass
                                           firstRowTitle:(NSString *)title
                                   firstRowMethod:(NSString *)method

{
    BSTableContentObject *bsContent=[BSTableContentObject initContentObject:title methodName:method];
    
    return [[super alloc]
            initWithHeaderVcFirstClassContent:header vcClass:vcClass bsContent:bsContent];
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}

-(instancetype)initWithHeaderVcFirstClassContent: (NSString *)tableHeader
                                    vcClass:(Class)contentClass
                             bsContent:(BSTableContentObject *)bscontent{
    self=[self init];
    if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    self.header=tableHeader;
    self.vcClass=contentClass;
    [self.content addObject:bscontent];
    return self;
}

-(instancetype)initWithHeaderVcClassContent: (NSString *)tableHeader
                                    vcClass:(Class)contentClass
                                  bsContentArray:(NSMutableArray *)bsContents{
    self=[self init];
    if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    self.header=tableHeader;
    self.vcClass=contentClass;
    [self.content addObjectsFromArray:bsContents];
    return self;
}

-(void)addBSTableContent:(BSTableContentObject *)bsContent{
    if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    [self.content addObject:bsContent];
}
@end
