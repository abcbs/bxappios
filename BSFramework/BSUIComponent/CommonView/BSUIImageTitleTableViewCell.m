//
//  BSUIImageTitleTableViewCell.m
//  KTAPP
//
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIImageTitleTableViewCell.h"
#import "BSUIFrameworkHeader.h"

@implementation BSUIImageTitleTableViewCell

@synthesize cellImage;
@synthesize cellName;

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    self.cellName.text =[bsContentObject colTitle];
    self.cellImage.image=[UIImage imageNamed:[bsContentObject colImageName]];
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
     
    UIImageView *cell=
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:[bsContentObject colImageName]]];
    [cell setFrame:BSRectMake(SCREEN_WIDTH/3, 10, 100, 100)];
    UILabel *lable=[[UILabel alloc]initWithFrame:(BSRectMake(SCREEN_WIDTH/3+20, 120, 90, 60))];
    
    lable.text=[bsContentObject colTitle];
    [self.contentView addSubview:lable];
    [self.contentView addSubview:cell];
    return self;
}
-(void)dealloc{
    self.cellImage.image=nil;
}
@end
