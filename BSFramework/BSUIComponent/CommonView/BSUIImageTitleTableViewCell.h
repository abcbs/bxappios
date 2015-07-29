//
//  BSUIImageTitleTableViewCell.h
//  KTAPP
//  一个表格的一行包括一个图标和一个标题
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"
#import "BSUITableCellOperation.h"

@interface BSUIImageTitleTableViewCell : UITableViewCell<BSUITableCellOperation>
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *cellName;


/**
 *NIB或者故事板方式调用方法
 */
-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject;

/**
 *手工编码的调用方法
 */
-(UITableViewCell *)viewCellWithHandBSContentObject:(BSTableContentObject *)bsContentObject;

@end
