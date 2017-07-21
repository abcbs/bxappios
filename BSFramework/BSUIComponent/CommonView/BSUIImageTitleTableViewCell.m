//
//  BSUIImageTitleTableViewCell.m
//  KTAPP
//
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUIImageTitleTableViewCell.h"
#import "BSUIFrameworkHeader.h"

@implementation BSUIImageTitleTableViewCell

@synthesize cellImage;
@synthesize cellName;

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    self.cellName.text =[bsContentObject colTitle];
    self.cellImage.image=[UIImage imageNamed:[bsContentObject colImageName]];
    //self.frame=BSRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //self.contentView.frame=BSRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
     
    UIImageView *cell=
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:[bsContentObject colImageName]]];
    [cell setFrame:BSRectMake(SCREEN_WIDTH/3, 10, 100, 100)];
    UILabel *lable=[[UILabel alloc]initWithFrame:(BSRectMake(SCREEN_WIDTH/3+16, 100, 90, 60))];
    
    lable.text=[bsContentObject colTitle];
    //self.frame=BSRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.contentView addSubview:lable];
    [self.contentView addSubview:cell];
    //[self addSubview:lable];
    //[self addSubview:cell];
    return self;
}
-(void)dealloc{
    self.cellImage.image=nil;
}
@end
