//
//  MoreView.m
//  KTAPP
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MoreView.h"

@interface MoreView ()

//定义ToolIndex类型的block,用于接受外界传过来的block
@property (nonatomic, strong) MoreIndex myBlock;

@end

@implementation MoreView

-(void) setMoreBlock:(MoreIndex) index{
    self.myBlock = index;
}

@end
