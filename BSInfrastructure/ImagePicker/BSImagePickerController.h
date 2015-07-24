//
//  BSImagePickerController.h
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class BSImagePickerController;

@protocol BSImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;
- (void)imagePickerControllerDidCancel:(BSImagePickerController *)imagePickerController;

- (BOOL)imagePickerController:(BSImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset;
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset;
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset;

@end

typedef NS_ENUM(NSUInteger, BSImagePickerMediaType) {
    BSImagePickerMediaTypeAny = 0,
    BSImagePickerMediaTypeImage,
    BSImagePickerMediaTypeVideo
};

@interface BSImagePickerController : UIViewController

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
