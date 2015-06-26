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
    self.cellName.text =[bsContentObject title];
    self.cellImage.image=[UIImage imageNamed:[bsContentObject imageName]];
    return self;
}

-(void)dealloc{
    self.cellImage.image=nil;
}
@end
