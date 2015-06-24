//
//  BSTableContentObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableContentObject.h"

@implementation BSTableContentObject

-(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(Class)clzz{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.title=title;
    self.method=name;
    self.vcClass=clzz;
    self.imageName=imageName;
    return self;
}

+(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(Class)clzz
{
    return [[super alloc] initContentObject:title methodName:name imageName:imageName vcClass:clzz];
}
@end
