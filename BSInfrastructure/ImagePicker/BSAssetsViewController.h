//
//  BSAssetsViewController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>

@class BSImagePickerController;
@class PHAssetCollection;

@interface BSAssetsViewController : UICollectionViewController

@property (nonatomic, weak) BSImagePickerController *imagePickerController;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
