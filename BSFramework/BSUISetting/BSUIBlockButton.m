//
//  BlockButton.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUIBlockButton.h"

@implementation BSUIBlockButton
@synthesize block;

- (id)initWithFrame:(CGRect)frame target:(UIViewController *)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:target
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)touchAction:(id)sender{
    block(self);
}
@end
