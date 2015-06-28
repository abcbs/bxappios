//
//  BlockButton.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIBlockButton.h"

@implementation BSUIBlockButton
@synthesize block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)touchAction:(id)sender{
    block(self);
}
@end
