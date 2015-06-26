//
//  TTTT.m
//  KTAPP
//
//  Created by admin on 15/6/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUISingleImageTableViewCell.h"
#import "BSUIFrameworkHeader.h"
@implementation BSUISingleImageTableViewCell

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    self.cellImge.image=[UIImage imageNamed:[bsContentObject imageName]];
    return self;
}

-(void)dealloc{
    self.cellImge.image=nil;
}
@end
