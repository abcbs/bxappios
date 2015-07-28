//
//  BSAssetsViewController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import "BSUIFrameworkHeader.h"
#import "BSPhotoImagePickerController.h"
#import "BSUICollectionCollectionViewController.h"

@class BSImagePickerController;


@interface BSPhotoTakeViewController : BSUICollectionCollectionViewController

@property (nonatomic, strong) BSPhotoImagePickerController * imagePickerController;

@property (nonatomic, strong) NSMutableArray *fetchResult;

@end
