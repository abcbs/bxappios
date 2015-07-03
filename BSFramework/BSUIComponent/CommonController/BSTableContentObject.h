//
//  BSTableContentObject.h
//  KTAPP
//  表格运行时，行的详细数据，目前包括头方法、实现的Controller，图标信息
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSTableContentObject : NSObject

/**
 *标题名称
 */
@property (copy, nonatomic) NSString *colTitle;

/**
 *标题图标
 */
@property (copy, nonatomic) NSString *colImageName;

/**
 *NIB和故事板方式的标示Identifer
 */

@property (copy, nonatomic) NSString * vcClass;
/**
 *手工编码时需要提供的实现类ViewController
 */
@property (copy, nonatomic) Class     colClass;


/**
 *跳转时执行的方法
 */
@property (copy, nonatomic) NSString *method;


/**
 *在页面跳转时，执行定制的method，所需参数的数据
 */
@property (copy,nonatomic) NSObject *neededMethodData;

/**
 *以SEL方式传递数据的Selector
 */
@property (assign,nonatomic) SEL action;

/**
 *以SEL方式传递参数的数据
 */
@property (assign,nonatomic)id  data;

/**
 *在故事板跳转中，故事板的名称
 */
@property (copy,nonatomic) NSString *storybordName;

/**
 *表格的具体Cell在实现中所需的样式
 */
@property (assign ,nonatomic) NSMutableDictionary *styleDiction;

/**
 *此变量没有提供和其他变量一起初始化的方法，在运行时会根据列的容量设置
 */
@property (assign,nonatomic)NSInteger colCapatibilty;

/**
 *此变量没有提供和其他变量一起初始化的方法，在运行时会根据列的容量设置
 */
@property (assign,nonatomic)UIViewController *callerViewController;
@property (assign,nonatomic)BOOL canUseStoryboard;

/**
 *使用故事板跳转，默认方式
 */
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName vcClass:(NSString *)clzzName;

/**
 *不使用故事板，编码方式或者nib方式跳转
 */
+(instancetype)initWithContentObject:(NSString *)title methodName:(NSString *)name imageName:(NSString *)imageName colClass:(Class)clzz;

//-(void)styleDiction

@end
