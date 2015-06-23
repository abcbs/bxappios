//
//  BSTableList.h
//  KTAPP
//
//  Created by admin on 15/6/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSTableList <NSObject>

-(long )firstDataId;

-(long )lastDataId;

-(int )pageCount;

- (void)headerRereshing;

- (void)footerRereshing;

- (void)loadMoreData:(long) warterId dataCount:(int)cellCount;


@end
