//
//  BSVideoIconView.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>

/************************************************************************
 可以将自定义的代码实时渲染到Interface Builder中。而它们之间的桥梁就是通过两个指令来完成，即@IBDesignable和@IBInspectable。我们通过@IBDesignable告诉Interface Builder这个类可以实时渲染到界面中，但是这个类必须是UIView或者NSView的子类。通过@IBInspectable可以定义动态属性，即可在attribute inspector面板中可视化修改属性值。
 *************************************************************************/
IB_DESIGNABLE
@interface BSVideoIconView : UIView

@property (nonatomic, strong) IBInspectable UIColor *iconColor;

@end
