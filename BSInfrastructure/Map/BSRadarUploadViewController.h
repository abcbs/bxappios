//
//  RadarUploadViewController.h
//  开发者利用周边雷达功能，可以便捷的在自己的应用内，帮助用户实现查找周边跟“我”使同样一款App的人，这样一个功能。
//

#import <UIKit/UIKit.h>
#import "BSCMFrameworkHeader.h"

#define MY_LOCATION_UPDATE_NOTIFICATION @"MY_LOCATION_UPDATE_NOTIFICATION"

@interface BSRadarUploadViewController : BSUICommonController

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (weak, nonatomic) IBOutlet UIButton *autoUploadButton;
@property (weak, nonatomic) IBOutlet UIButton *stopUploadButton;


- (IBAction)uploadAction:(id)sender;

- (IBAction)autoUploadAction:(id)sender;

- (IBAction)stopAutoUploadAction:(id)sender;

- (IBAction)clearAction:(id)sender;

- (IBAction)userIdTextEditEnd:(id)sender;

@end
