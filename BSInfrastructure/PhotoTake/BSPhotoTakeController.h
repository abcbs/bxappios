//
//  FDTakeController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCMFrameworkHeader.h"
#import "BSUIFrameworkHeader.h"
#import "Resources.h"

@class BSPhotoTakeController;

@protocol BSPhotoTakeDelegate <NSObject>

@optional
/**
 * 开始之后的取消操作
 */
- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt;

/**
 * 失败操作
 */
- (void)takeController:(BSPhotoTakeController *)controller didFailAfterAttempting:(BOOL)madeAttempt;

/**
 * 选取或拍一张照片成功
 */
- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(Resources *)info;

/**
 * 选取照片成功多张(3~9)
 */
- (void)takeController:(BSPhotoTakeController *)controller gotPhotoArray:(NSMutableArray *)photoImages withInfo:(NSMutableArray *)info;

/**
* 选取视频成功之后
 */
- (void)takeController:(BSPhotoTakeController *)controller gotVideo:(NSURL *)video withInfo:(NSDictionary *)info;

@end

@interface BSPhotoTakeController : BSUICommonController <UIImagePickerControllerDelegate>

@property (strong,nonatomic) UICollectionView *collectionView;

/**
 * 拍照或者从照片中选择图片
 */
- (void)takePhotoOrChooseFromLibrary;

/**
 *拍视频或者选择视频
 */
- (void)takeVideoOrChooseFromLibrary;

/**
 *拍照或者视频
 */
- (void)takePhotoOrVideoOrChooseFromLibrary;

/**
 *拍或者选择一张图片操作
 */
- (void)takeSinglePhotoOrChooseFromLibrary;

/**
 *拍或者选择多张图片操作
 */
- (void)takeMultPhotoOrChooseFromLibrary;


@property (nonatomic, unsafe_unretained) id <BSPhotoTakeDelegate> delegate;

@property (nonatomic, unsafe_unretained) UIViewController *viewControllerForPresentingImagePickerController;


// used in presentPopoverFromRect on iPads
@property (nonatomic, readwrite) CGRect popOverPresentRect;

@property (strong, nonatomic) UITabBar *tabBar;

/**
 * Whether to allow editing the photo
 */
@property (nonatomic, assign) BOOL allowsEditingPhoto;

/**
 * Whether to allow editing the video
 */
@property (nonatomic, assign) BOOL allowsEditingVideo;

/**
 * Selfie mode
 */
@property (nonatomic, assign) BOOL defaultToFrontCamera;


// Set these strings for custom action sheet button titles
/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *takePhotoText;

/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *takeVideoText;

/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *chooseFromLibraryText;

/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *chooseFromPhotoRollText;

/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *cancelText;

/**
 * Custom UI text (skips localization)
 */
@property (nonatomic, copy) NSString *noSourcesText;

@end
