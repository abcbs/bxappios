//
//  LOLoginUserDetailViewController.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOLoginUserDetailViewController.h"
#import "LOLoginUserMaintainViewController.h"
#import "LBModelsHeader.h"

@interface LOLoginUserDetailViewController ()

@end

@implementation LOLoginUserDetailViewController
@dynamic loginUser;
//头像图片
@dynamic  headerImage;

//匿名，用户名
@dynamic  anonName;

//真实姓名
@dynamic  realName;

//密码
@dynamic password;

//地址
@dynamic address;

//手机号
@dynamic phone;

@dynamic manSex;

@dynamic womenSex;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self display];
}


- (void)dealloc{
    [self clearDisplayView];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //MaintainCatalogue
    LOLoginUserMaintainViewController *edit = (LOLoginUserMaintainViewController *)segue.destinationViewController;
    edit.editDelegate = self;
    edit.loginUser = self.loginUser;;
}

-(void)modifiedStyle{
    
    if (self.loginUser) {
        
        [self.realName setEnabled: NO];
        [self.realName setEnabled:NO];
        [self.realName setEnabled:NO];
    }else{
        self.navigationItem.rightBarButtonItems=nil;
        
    }
}
-(void)display{
    
    if (self.loginUser) {
        self.anonName.text=self.loginUser.userName;
        self.realName.text=self.loginUser.realName;
        self.password.text=self.loginUser.passWord;
        self.address.text=self.loginUser.address;
        self.phone.text=self.loginUser.phoneNum;

        if ([self.loginUser.sex  isEqualToString:@"1"]) {
            self.manSex.selected=YES;
            self.womenSex.selected=NO;
        }else if([self.loginUser.sex  isEqualToString:@"2"]){
            self.manSex.selected=NO;
            self.womenSex.selected=YES;
        }
            
    }
    
}

-(void)editedLoginUser:(LoginUser *)user{
    self.loginUser =user ;
    
    [_browseDelegate editedLoginUser:self.loginUser];
    [self display];
}

- (void)addLoginUser:(LoginUser *)user{
    self.loginUser=user;
    [_browseDelegate addLoginUser:self.loginUser];
    [self display];
}

@end
