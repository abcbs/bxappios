//
//  adsCell.h
//  民生小区
//
//  Created by 闫青青 on 15/6/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol adsDelegate<NSObject>
- (void)adsButtonClicked;
@end
@interface adsCell : UITableViewCell
@property (nonatomic, weak) id <adsDelegate>delegate1;
@end
