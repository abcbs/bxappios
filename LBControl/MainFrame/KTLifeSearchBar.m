//
//  KTLifeSearchBar.m
//  主界面，生活服务搜索，废除
//
//  Created by 罗芳芳 on 15/4/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLifeSearchBar.h"

@implementation KTLifeSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 通过xib/Storboard创建时调用
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    // 设置边框样式
    self.borderStyle = UITextBorderStyleRoundedRect;
    // 设置提醒文本
    self.placeholder = @"请输入商家、产品";
    //设置右边的图标
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_discover"]];
    self.rightView = icon;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    //设置清除按钮
    self.clearButtonMode = UITextFieldViewModeAlways;
}
-(void)setrightIconName:(NSString *)rightIconName
{
    _rightIconName = rightIconName;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightIconName]];
  // icon.width = 30;
    icon.contentMode = UIViewContentModeCenter;
    self.rightView = icon;
}
#pragma mark -监听 scrollview的拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


@end
