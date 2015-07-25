//
//  FDTakeController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSPhotoTakeController;

@protocol BSPhotoTakeDelegate <NSObject>

@optional
/**
 * Delegate method after the user has started a take operation but cancelled it
 * 开始之后的取消操作
 */
- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt;

/**
 * Delegate method after the user has started a take operation but it failed
 * 失败操作
 */
- (void)takeController:(BSPhotoTakeController *)controller didFailAfterAttempting:(BOOL)madeAttempt;

/**
 * Delegate method after the user has successfully taken or selected a photo
 * 选取照片成功
 */
- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info;

/**
 * Delegate method after the user has successfully taken or selected a video
 * 选取视频成功之后
 */
- (void)takeController:(BSPhotoTakeController *)controller gotVideo:(NSURL *)video withInfo:(NSDictionary *)info;
@end

@interface BSPhotoTakeController : NSObject <UIImagePickerControllerDelegate>

/**
 * Presents the user with an option to take a photo or choose a photo from the library
 */
- (void)takePhotoOrChooseFromLibrary;

/**
 * Presents the user with an option to take a video or choose a video from the library
 */
- (void)takeVideoOrChooseFromLibrary;

/**
 * Presents the user with an option to take a photo/video or choose a photo/video from the library
 */
- (void)takePhotoOrVideoOrChooseFromLibrary;

/**
 * The delegate to receive updates from FDTake
 */
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
