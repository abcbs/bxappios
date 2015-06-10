//
//  userProtocol.m
//  民生小区
//
//  Created by 闫青青 on 15/5/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "userProtocol.h"

@interface userProtocol ()
- (IBAction)buttonClicked:(id)sender;

@end

@implementation userProtocol

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.backImageView addSubview:self.view];
//    [self.backButton addSubview:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
