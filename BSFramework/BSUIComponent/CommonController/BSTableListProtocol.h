//
//  BSTableList.h
//  KTAPP
//采用JMfresh和MBProgressHUD实现上拉更新下拉下载功能定义的实现协议类
//
//  Created by admin on 15/6/14.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSTableListProtocol <NSObject>

-(long )firstDataId;

-(long )lastDataId;

-(int )pageCount;

- (void)headerRereshing;

- (void)footerRereshing;

- (void)loadMoreData:(long) warterId dataCount:(int)cellCount;


@end
