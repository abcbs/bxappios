//
//  adsCell.m
//  民生小区
//
//  Created by 闫青青 on 15/6/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "adsCell.h"
#import "addressController.h"
#import "cleaning.h"
@interface adsCell()
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic, assign) BOOL isSelected;
@end
@implementation adsCell
- (IBAction)buttonSelect:(id)sender {
    if([self.delegate1 respondsToSelector:@selector(adsButtonClicked)]){
        [self.delegate1 adsButtonClicked];
    }
    if (_isSelected) {
        [_button2 setImage:[UIImage imageNamed:@"a3"] forState:UIControlStateNormal];
        _isSelected = NO;
        
    }else{
        [_button2 setImage:[UIImage imageNamed:@"a4"] forState:UIControlStateNormal];
        _isSelected = YES;
        
    }
    
}

- (void)awakeFromNib {
    [_button2 setImage:[UIImage imageNamed:@"a3"] forState:UIControlStateNormal];
    [_button2 setImage:[UIImage imageNamed:@"a4"] forState:UIControlStateHighlighted];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
