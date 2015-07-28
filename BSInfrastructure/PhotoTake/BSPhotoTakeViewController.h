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
@class PHAssetCollection;

@interface BSPhotoTakeViewController : BSUICollectionCollectionViewController


@property (nonatomic, strong) NSMutableArray *assetCollection;



@property (nonatomic, strong) BSPhotoImagePickerController * imagePickerController;



@end
