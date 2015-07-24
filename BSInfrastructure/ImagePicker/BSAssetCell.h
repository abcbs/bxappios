//
//  BSAssetCell.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>

@class BSVideoIndicatorView;

@interface BSAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet BSVideoIndicatorView *videoIndicatorView;

@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;

@end
