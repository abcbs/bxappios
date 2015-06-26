//
//  TTTT.h
//  KTAPP
//
//  Created by admin on 15/6/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIImageTitleTableViewCell.h"
#import "BSUIFrameworkHeader.h"

@interface BSUISingleImageTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *cellImge;




-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject;


@end
