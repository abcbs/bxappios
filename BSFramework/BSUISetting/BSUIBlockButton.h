//
//  BlockButton.h
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BSUIBlockButton;
//定义块类型
typedef void (^TouchButton)(BSUIBlockButton*);

@interface BSUIBlockButton : UIButton
    @property(nonatomic,copy) TouchButton block;
@end


