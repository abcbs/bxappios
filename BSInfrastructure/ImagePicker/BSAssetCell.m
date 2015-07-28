//
//  BSAssetCell.m
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import "BSAssetCell.h"

@interface BSAssetCell ()

@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

@implementation BSAssetCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    // Show/hide overlay view
    self.overlayView.hidden = !(selected && self.showsOverlayViewWhenSelected);
}
/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
              
    }
    return self;
}*/

@end
