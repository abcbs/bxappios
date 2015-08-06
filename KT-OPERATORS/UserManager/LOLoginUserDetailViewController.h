//
//  LOLoginUserDetailViewController.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserMaintainViewController.h"
#import "LOLoginUserDelegate.h"
#import "LoginUser.h"

@interface LOLoginUserDetailViewController : LOLoginUserMaintainViewController<LOLoginUserDelegate>

@property (weak, nonatomic) id<LOLoginUserDelegate> browseDelegate;

@property (nonatomic,strong) LoginUser *loginUser;

@end
