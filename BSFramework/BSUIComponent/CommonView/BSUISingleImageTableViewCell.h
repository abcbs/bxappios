//
//  TTTT.h
//  KTAPP
//
//  Created by admin on 15/6/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIImageTitleTableViewCell.h"
#import "BSUIFrameworkHeader.h"
#import "BSUITableCellOperation.h"

@interface BSUISingleImageTableViewCell : UITableViewCell<BSUITableCellOperation>

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
/**
 *NIB或者故事板方式调用方法
 */
-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject;

/**
 *手工编码的调用方法
 */
-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject;



@end
