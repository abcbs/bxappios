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
@synthesize headerImageName;
@synthesize content;

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName                                     vcClass:(Class)vcClass
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName vcClass:vcClass bsContentArray:bsContents];
}



- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}



-(instancetype)initWithHeaderVcClassContent: (NSString *)tableHeader
                                  imageName:(NSString *)imageName                                      vcClass:(Class)contentClass
                                  bsContentArray:(NSMutableArray *)bsContents{
    self=[self init];
    if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    self.header=tableHeader;
    self.headerImageName=imageName;
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
