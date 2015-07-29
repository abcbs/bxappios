//
//  BSUIFiveColTableViewCell.h
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUITableMultCellOperation.h"
@interface BSUIFiveColTableViewCell : UITableViewCell<BSUITableMultCellOperation>


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (weak, nonatomic) IBOutlet UIButton *imgButton;

/*
@property (weak, nonatomic) IBOutlet UIButton *scButton;


@property (weak, nonatomic) IBOutlet UIButton *fourButton;


@property (weak, nonatomic) IBOutlet UIButton *fiveButton;


@property (weak, nonatomic) IBOutlet UILabel *scLebel;


@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (weak, nonatomic) IBOutlet UILabel *fourLabel;

@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
*/
@end
