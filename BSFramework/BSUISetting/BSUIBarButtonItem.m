//
//  BSUIBarButtonItem.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIBarButtonItem.h"
#import "BSUIFrameworkHeader.h"

@implementation BSUIBarButtonItem
@synthesize block;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super initWithTitle:title style:UIBarButtonItemStylePlain
                         target:target action:action];
    self.tintColor=[UIColor redColor];
    if (title) {
        [self setTitle:title];
    }else{
        [self setTitle:[Conf appInfo]];
    }
    return self;
    
}

@end
