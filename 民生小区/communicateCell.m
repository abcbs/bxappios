//
//  communicateCell.m
//  民生小区
//
//  Created by 闫青青 on 15/6/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "communicateCell.h"
#import "communicateController.h"
@interface communicateCell()


- (IBAction)zan:(id)sender;
- (IBAction)comment:(id)sender;

@end
@implementation communicateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)zan:(id)sender {
    if ([self.delegate respondsToSelector:@selector(communicateZanClick)]) {
        [self.delegate communicateZanClick];
    }
    
}

- (IBAction)comment:(id)sender {
    if ([self.delegate respondsToSelector:@selector(communicateCommentClick)]) {
        [self.delegate communicateCommentClick];
    }
}
@end
