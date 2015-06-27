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

@synthesize imageView;

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    self.cellImge.image=[UIImage imageNamed:[bsContentObject colImageName]];
    self.cellImge.width=BSMarginX(SCREEN_WIDTH);
    self.cellImge.height=BSMarginY(115);
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
    
    UIImageView *cell=
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:[bsContentObject colImageName]]];
    cell.width=BSMarginX(SCREEN_WIDTH);
    cell.height=BSMarginY(115);
    
    [self.contentView addSubview:cell];
    return self;
}
-(void)dealloc{
    self.cellImge.image=nil;
}
@end
