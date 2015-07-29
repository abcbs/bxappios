//
//  BSAlbumsViewController.h
//  相册类型列表
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"
@class BSImagePickerController;

@interface BSAlbumsViewController : BSUITableViewCanEditedController

@property (nonatomic, weak) BSImagePickerController *imagePickerController;

@end
