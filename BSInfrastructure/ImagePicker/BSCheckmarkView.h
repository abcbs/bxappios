//
//  BSCheckmarkView.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BSCheckmarkView : UIView

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat checkmarkLineWidth;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *bodyColor;
@property (nonatomic, strong) IBInspectable UIColor *checkmarkColor;

@end
