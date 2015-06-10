//
//  KTFooterView.m
//  民生小区
//
//  Created by L on 15/4/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTFooterView.h"
@interface KTFooterView()
- (IBAction)loadMoreClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIView *loadMoreView;


@end

@implementation KTFooterView

+(instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"KTFooterView" owner:nil options:nil] lastObject];
}

//当xib中的子控件加载完成的时候调用
-(void)awakeFromNib
{
    //设置按钮的圆角效果
    self.loadMoreButton.layer.cornerRadius = 5;
    self.loadMoreButton.layer.masksToBounds = YES;
    
}

- (IBAction)loadMoreClick:(UIButton *)sender {
    //隐藏当前点击的按钮
    sender.hidden = YES;
    //显示小View
    self.loadMoreView.hidden = NO;
    
    // 延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        sender.hidden = NO;
        self.loadMoreView.hidden = YES;
        
        // 加载数据
        if ([self.delegate respondsToSelector:@selector(footerViewDidClickLoadMore:)]) {
            //向代理发送消息
            [self.delegate footerViewDidClickLoadMore:self];
        }
    });
}
@end
