//
//  MoreView.h
//  KTAPP
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIView
//定义block块变量类型，用于回调,把本View上的按钮的index传到Controller中
typedef void (^MoreIndex) (NSInteger index);

-(void) setMoreBlock:(MoreIndex) index;
@end
