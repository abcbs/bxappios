//
//  KTTabBarButton.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTTabBarButton.h"

@implementation KTTabBarButton

// 通过代码创建控件时会调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 设置图片居中
    self.imageView.contentMode = UIViewContentModeCenter;
    // 设置标题居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 设置文字字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置按钮标题颜色
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
}


@end
