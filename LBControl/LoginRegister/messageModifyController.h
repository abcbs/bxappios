//
//  messageModifyController.h
//  KTAPP
//
//  Created by 闫青青 on 15/6/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageModifyController : UIViewController
//取图片的base-64
@property (strong, nonatomic) NSString *contents;
//上传头像错误信息
@property (strong, nonatomic) NSDictionary *errorHeadImage;

@end
