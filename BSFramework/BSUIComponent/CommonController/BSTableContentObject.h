//
//  BSTableContentObject.h
//  KTAPP
//  表格运行时，行的详细数据，目前包括头方法、实现的Controller，图标信息
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSTableContentObject : NSObject

@property (copy, nonatomic) NSString *colTitle;
@property (copy, nonatomic) NSString *method;
@property (copy, nonatomic) NSString *colImageName;
@property (copy, nonatomic) NSString * vcClass;
@property (copy, nonatomic) Class     colClass;

/**
 *使用故事板跳转，默认方式
 */
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName;

/**
 *不使用故事板，编码方式或者nib方式跳转
 */
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName colClass:(Class)clzz;

@end
