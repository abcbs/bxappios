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
    //UILabel *lable=[[UILabel alloc]initWithFrame:<#(CGRect)#>];
    UILabel *lable=[[UILabel alloc]init];
    lable.width=BSMarginX(SCREEN_WIDTH);
    lable.height=BSMarginY(115);
    lable.text=[bsContentObject colTitle];
    [self.contentView addSubview:lable];
    
    UIImageView *cell=
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:[bsContentObject colImageName]]];
    cell.width=BSMarginX(SCREEN_WIDTH);
    cell.height=BSMarginY(115);
    
    [self.contentView addSubview:cell];
    return self;
}
-(void)dealloc{
    self.cellImage.image=nil;
}
@end
