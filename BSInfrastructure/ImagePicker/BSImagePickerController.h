//
//  BSImagePickerController.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "BSUICommonController.h"

@class BSImagePickerController;

@protocol BSImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;
- (void)imagePickerControllerDidCancel:(BSImagePickerController *)imagePickerController;

- (BOOL)imagePickerController:(BSImagePickerController *)imagePickerController shouldSelectAsset:(UIImage *)asset;
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didSelectAsset:(UIImage *)asset;
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didDeselectAsset:(UIImage *)asset;

@end

typedef NS_ENUM(NSUInteger, BSImagePickerMediaType) {
    BSImagePickerMediaTypeAny = 0,
    BSImagePickerMediaTypeImage,
    BSImagePickerMediaTypeVideo
};

@interface BSImagePickerController : BSUICommonController

@property (nonatomic, weak) id<BSImagePickerControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *assetCollectionSubtypes;
@property (nonatomic, assign) BSImagePickerMediaType mediaType;

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, assign) BOOL showsNumberOfSelectedAssets;

@property (nonatomic, assign) NSUInteger numberOfColumnsInPortrait;
@property (nonatomic, assign) NSUInteger numberOfColumnsInLandscape;

@end
