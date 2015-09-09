//
//  FaceView.m
//  KTAPP
//
//  主要就是block回调的使用，就是封装了一个自定义的button,
//  http://www.cnblogs.com/ludashi/p/3964969.html
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "FaceView.h"

@interface FaceView ()
    @property(strong, nonatomic) FaceBlock block;
    @property (strong, nonatomic) UIImageView *imageView;
@end

@implementation FaceView

//初始化图片
- (id)initWithFrame:(CGRect)frame
{
    //face的大小
    frame.size.height = 30;
    frame.size.width = 30;
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void) setFaceBlock:(FaceBlock)block
{
    self.block = block;
}


-(void) setImage:(UIImage *)image ImageText:(NSString *)text
{
    //显示图片
    [self.imageView setImage:image];
    
    //把图片存储起来
    self.headerImage = image;
    
    self.imageText = text;
}

//点击时回调
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //判断触摸的结束点是否在图片中
    if (CGRectContainsPoint(self.bounds, point))
    {
        //回调,把该头像的信息传到相应的controller中
        self.block(self.headerImage, self.imageText);
    }
}


@end
