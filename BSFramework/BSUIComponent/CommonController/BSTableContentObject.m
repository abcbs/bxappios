//
//  BSTableContentObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableContentObject.h"

@implementation BSTableContentObject

-(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name;{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.title=title;
    self.method=name;
    return self;
}

+(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name;{
    return [[super alloc] initContentObject:title methodName:name];
}
@end
