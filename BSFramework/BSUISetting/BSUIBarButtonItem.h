//
//  BSUIBarButtonItem.h
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSUIBarButtonItem;
//定义块类型
typedef void (^BSButtonItem)(BSUIBarButtonItem*);

@interface BSUIBarButtonItem : UIBarButtonItem



@property(nonatomic,copy) BSButtonItem block;


- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
