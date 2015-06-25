//
//  BSTableContentObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableContentObject.h"

@implementation BSTableContentObject


-(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzz{
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

+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzz
{
    return [[super alloc] initWithContentObject:title methodName:name imageName:imageName vcClass:clzz];
}

-(NSString *)description

{
    return [NSString stringWithFormat:@"标题: %@ \t控制器实现类: %@\t方法:%@\t显示图片:%@",
            self.title,self.vcClass,self.method,self.imageName];
    
}
@end
