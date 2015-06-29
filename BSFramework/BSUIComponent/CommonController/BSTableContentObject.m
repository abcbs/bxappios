//
//  BSTableContentObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableContentObject.h"

@implementation BSTableContentObject
@synthesize colTitle;
@synthesize method;
@synthesize vcClass;
@synthesize colImageName;
@synthesize colClass;
@synthesize neededMethodData;
@synthesize styleDiction;
@synthesize action;
@synthesize data;

-(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name
                           imageName:(NSString *)imageName vcClass:(NSString *)clzzName colClass:(Class)clzz{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.colTitle=title;
    self.method=name;
    self.vcClass=clzzName;
    self.colImageName=imageName;
    self.colClass=clzz;
    return self;
}

+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName colClass:(Class)clzz{
    return [[super alloc] initWithContentObject:title methodName:name
                                      imageName:imageName vcClass:nil colClass:clzz];}

+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName
{
    return [[super alloc] initWithContentObject:title methodName:name
                                      imageName:imageName vcClass:clzzName colClass:nil];
}

-(NSString *)description

{
    return [NSString stringWithFormat:@"标题: %@ \t控制器实现类: %@\t方法:%@\t显示图片:%@",
            self.colTitle,self.vcClass,self.method,self.colImageName];
    
}
@end
