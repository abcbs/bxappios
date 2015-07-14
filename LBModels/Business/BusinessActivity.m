//
//  BusinessActivity.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessActivity.h"

@implementation BusinessActivity

-(NSString *)description{
    return [NSString stringWithFormat:@"商家活动:%ld，活动标题:%@ 活动内容:%@",
            (long)self.id,self.title,self.content];
}

@end
