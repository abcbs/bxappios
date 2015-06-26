//
//  KTLifeIndexCell.m
//  民生小区
//
//  Created by 闫青青 on 15/6/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLifeIndexCell.h"
@interface KTLifeIndexCell()


@end
@implementation KTLifeIndexCell
@synthesize bigImage;



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    
    self.bigImage.image=[UIImage imageNamed:[bsContentObject imageName]];
    return self;
}

@end
