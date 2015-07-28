//
//  BSImagePickerController.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import "BSUICommonController.h"

@class BSPhotoImagePickerController;

@protocol BSPhoneImagePickerControllerDelegate <NSObject>

@required
- (void)imagePhotoPickerController:(BSPhotoImagePickerController *)imagePickerController didFinishPickingAssets:(NSMutableArray *)assets;

@optional
- (void)imagePhotoPickerControllerDidCancel:(BSPhotoImagePickerController *)imagePickerController;

- (BOOL)imagePhotoPickerController:(BSPhotoImagePickerController *)imagePickerController shouldSelectAsset:(UIImage *)asset;

- (void)imagePhotoPickerController:(BSPhotoImagePickerController *)imagePickerController didSelectAsset:(UIImage *)asset;

- (void)imagePhotoPickerController:(BSPhotoImagePickerController *)
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

-(void)selectPhotoImage:(UIImage *)selectImage;

-(void)reloadCollectionData;

-(void)removeCollectionObjects;

@end
