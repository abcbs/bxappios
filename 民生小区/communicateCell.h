//
//  communicateCell.h
//  民生小区
//
//  Created by 闫青青 on 15/6/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol communicateCellDelegate<NSObject>

- (void)communicateZanClick;
- (void)communicateCommentClick;
@end
@interface communicateCell : UITableViewCell

@property(nonatomic ,weak) id<communicateCellDelegate> delegate;



@end
