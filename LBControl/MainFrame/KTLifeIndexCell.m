//
//  KTLifeIndexCell.m
//  民生小区
//
//  Created by 闫青青 on 15/6/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLifeIndexCell.h"
#import "BSUIFrameworkHeader.h"

@interface KTLifeIndexCell()


@end
@implementation KTLifeIndexCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
        return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
    
       return self;
}
-(void)dealloc{
   // self.cellImge.image=nil;
}


@end
