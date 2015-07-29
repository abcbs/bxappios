//
//  BusinessProductDomail.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BusinessProductDomail.h"

@implementation BusinessProductDomail

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_pusinessProduct forKey:@"pusinessProduct"];
     
    [aCoder encodeObject:_businessProductComment
                  forKey:@"businessProductComment"];
   
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    _pusinessProduct= [aDecoder decodeObjectForKey:@"pusinessProduct"];
    
    _businessProductComment= [aDecoder decodeObjectForKey:@"businessProductComment"];
    
    return self;
}

@end
