//
//  BSTableContentObject.h
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSTableContentObject : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *method;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) Class vcClass;

-(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(Class)clzz;

+(instancetype)initContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(Class)clzz;
@end
