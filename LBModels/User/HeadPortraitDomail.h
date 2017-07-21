//
//  HeadPortraitDomail.h
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadPortraitDomail : NSObject

//头像的base64编码
@property (nonatomic, retain)NSString *headPortrait;

//图片的后缀，也就是图像格式
@property (nonatomic, copy)NSString *picSuffix;

//会话ID
@property (nonatomic, copy)NSString *sessionId;

@end
