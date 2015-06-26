//
//  BSUIImageTitleTableViewCell.h
//  KTAPP
//  一个表格的一行包括一个图标和一个标题
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSUIImageTitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellImage;

@property (weak, nonatomic) IBOutlet UIView *cellName;

@end
