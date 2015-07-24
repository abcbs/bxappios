//
//  BLCentralExtention.h
//  KTAPP
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

//BL控制器代理，跳转、添加、维护等操作的规定
@protocol BLCentralExtention <NSObject>
@optional
//刷新列表操作
- (void)refreshBLEInfo:(BLEInfo *)bleInfo;
- (void)addBLEInfo:(BLEInfo *)bleInfo;
- (void)editBLEInfo:(BLEInfo *)bleInfo;
@end