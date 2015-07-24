//
//  BSVideoIndicatorView.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>

#import "BSVideoIconView.h"
#import "BSSlomoIconView.h"

@interface BSVideoIndicatorView : UIView

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet BSVideoIconView *videoIcon;
@property (nonatomic, weak) IBOutlet BSSlomoIconView *slomoIcon;


@end
