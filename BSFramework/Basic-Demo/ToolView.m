//
//  ToolView.m
//  KTAPP
//
//  ToolView就是在主屏幕上下面的类似于TabBar的东西，
//  当键盘出来的时候,ToolView会运动到键盘上面的位置。为了使用不同的屏幕，也需要用自动布局来实现。
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 KIngTeller. All rights reserved.
//

#import "ToolView.h"

@interface ToolView ()

//定义ToolIndex类型的block,用于接受外界传过来的block
@property (nonatomic, strong) ToolIndex myBlock;

@end


@implementation ToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1初始化表情按钮
        UIButton *faceButton = [[UIButton alloc] initWithFrame:CGRectZero];
        faceButton.backgroundColor = [UIColor orangeColor];
        [faceButton setTitle:@"建议查询" forState:UIControlStateNormal];
        [faceButton setShowsTouchWhenHighlighted:YES];
        [faceButton addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:faceButton];
        
        
        //2.初始化更多按钮
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectZero];
        moreButton.backgroundColor = [UIColor grayColor];
        [moreButton setTitle:@"精确查询" forState:UIControlStateNormal];
        [moreButton setShowsTouchWhenHighlighted:YES];
        [moreButton addTarget:self action:@selector(tapMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreButton];
        
        
        //给我们的按钮添加约束来让按钮来占满toolView;
        faceButton.translatesAutoresizingMaskIntoConstraints = NO;
        moreButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        //添加水平约束
        NSArray *buttonH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[faceButton][moreButton(==faceButton)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(faceButton,moreButton)];
        [self addConstraints:buttonH];
        
        //添加垂直约束
        NSArray *button1V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[faceButton]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(faceButton)];
        [self addConstraints:button1V];
        
        NSArray *button2V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[moreButton]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(moreButton)];
        [self addConstraints:button2V];
        
    }
    return self;
}

//接受传入的回调
-(void) setToolIndex:(ToolIndex)toolBlock
{
    self.myBlock = toolBlock;
}

//点击表情按钮要回调的方法
-(void) tapFaceButton: (id) sender
{
    self.myBlock(1);
}

//点击more要回调的方法
-(void) tapMoreButton: (id) sender
{
    self.myBlock(2);
}


@end
