//
//  ImageModelClass.h
//  KTAPP
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModelClass : NSObject

//保存数据
-(void)save:(NSData *) image ImageText:(NSString *) imageText;
//查询所有的图片
-(NSArray *) queryAll;

@end
