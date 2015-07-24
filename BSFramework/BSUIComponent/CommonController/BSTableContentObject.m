//
//  BSTableContentObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSTableContentObject.h"
#import <UIKit/UIKit.h>

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
@synthesize storybordName;
@synthesize colCapatibilty;
@synthesize callerViewController;
@synthesize canUseStoryboard;

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
-(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName storybord:(NSString *)storybord{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.colTitle=title;
    self.method=name;
    self.vcClass=clzzName;
    self.colImageName=imageName;
    self.storybordName=storybord;
    self.canUseStoryboard=YES;
    return self;

    
    return self;
    
}
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName colClass:(Class)clzz{
    return [[super alloc] initWithContentObject:title methodName:name
                                      imageName:imageName vcClass:nil colClass:clzz];
}

+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName storybord:(NSString *)storybordName{
    return [[super alloc] initWithContentObject:title methodName:name imageName:imageName vcClass:clzzName storybord:storybordName];
    
}
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName
{
    return [[super alloc] initWithContentObject:title methodName:name
                                      imageName:imageName vcClass:clzzName colClass:nil];
}

+(instancetype)initWithController:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)vcClass canUseStoryboard:(BOOL)useStoryboard{
    return [[super alloc] initWithController:callerController
                                   storybord:storybordName identity:vcClass canUseStoryboard:useStoryboard];
}


-(instancetype)initWithController:(UIViewController *)callerController storybord:(NSString *)storybord identity:(NSString *)vc canUseStoryboard:(BOOL)useStoryboard{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.callerViewController=callerController;
    self.vcClass=vc;
    self.storybordName=storybord;
    self.canUseStoryboard=useStoryboard;
    return self;
}

-(NSString *)description

{
    return [NSString stringWithFormat:@"标题: %@ \t控制器实现类: %@\t方法:%@\t显示图片:%@",
            self.colTitle,self.vcClass,self.method,self.colImageName];
    
}
@end
