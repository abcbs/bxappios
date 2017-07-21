//
//  HistoryImage.h
//  KTAPP
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryImage : NSObject

@property (nonatomic, strong) NSData *headerImage;
@property (nonatomic, strong) NSString *imageText;
@property (nonatomic, strong) NSDate *time;
@end
