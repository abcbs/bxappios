//
//  KTLifeIndexCell.h
//  民生小区
//
//  Created by 闫青青 on 15/6/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"

@interface KTLifeIndexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

-(UITableViewCell *)viewCellWithBSContentObject:(BSTableContentObject *)bsContentObject;

@end
