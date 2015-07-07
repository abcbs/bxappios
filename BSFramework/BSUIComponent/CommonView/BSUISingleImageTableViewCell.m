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
    /*
    CGFloat height=BSMarginY(120);
    if (IS_IPHONE5) {
        height= BSMarginX(120);
    }else if  (IS_IPHONE_6){
        height= BSMarginX(120);
    }else if (IS_IPHONE_6PLUS){
        height= BSMarginX(120);
        
    }else{//4s
        height =BSMarginX(60);
    }
    self.bigImage.height=height;
     */
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
    
    return self;
}
-(void)dealloc{
    self.bigImage.image=nil;
}

@end
