//
//  BSUIDefaultTableViewCell.m
//  KTAPP
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUIDefaultTableViewCell.h"

@implementation BSUIDefaultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject{
    
    self.textLabel.tintColor=[BSUIComponentView navigationColor];
    self.textLabel.text =bsContentObject.colTitle ;
    return self;
}

-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject{
    self.textLabel.tintColor=[BSUIComponentView navigationColor];
    self.textLabel.text =bsContentObject.colTitle ;
    return self;
}

@end
