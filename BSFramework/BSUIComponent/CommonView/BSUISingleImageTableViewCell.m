//
//  BSUISingleImageTableViewCell.m
//  KTAPP
//  图标显示方式
//  Created by admin on 15/6/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUISingleImageTableViewCell.h"
#import "BSUIFrameworkHeader.h"
@implementation BSUISingleImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    self.bigImage.image = [UIImage imageNamed:bsContentObject.colImageName];
    
    CGFloat height=BSMarginY(120);
    CGFloat width=BSMarginX(SCREEN_WIDTH);
    //设置默认的宽度、高度
    self.bigImage.height=height;
    self.bigImage.width=width;
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
    
    return self;
}
-(void)dealloc{
    self.bigImage.image=nil;
}

@end
