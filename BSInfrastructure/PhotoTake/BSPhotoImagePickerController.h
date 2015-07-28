//
//  BSImagePickerController.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import "BSUICommonController.h"

@class BSPhotoImagePickerController;

@protocol BSPhoneImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(BSPhotoImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;

- (void)imagePickerControllerDidCancel:(BSPhotoImagePickerController *)imagePickerController;

- (BOOL)imagePickerController:(BSPhotoImagePickerController *)imagePickerController shouldSelectAsset:(UIImage *)asset;

- (void)imagePickerController:(BSPhotoImagePickerController *)imagePickerController didSelectAsset:(UIImage *)asset;

- (void)imagePickerController:(BSPhotoImagePickerController *)
imagePickerController didDeselectAsset:(UIImage *)asset;



@end



@interface BSPhotoImagePickerController : BSUICommonController


@property (nonatomic, weak) id<BSPhoneImagePickerControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *assetCollectionSubtypes;

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, assign) BOOL showsNumberOfSelectedAssets;

@property (nonatomic, assign) NSUInteger numberOfColumnsInPortrait;
@property (nonatomic, assign) NSUInteger numberOfColumnsInLandscape;

@end
