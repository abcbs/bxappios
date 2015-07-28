//
//  FDViewController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "BSPhotoTakeController.h"
#import "BSPhotoImagePickerController.h"

@interface BSPhotoViewController : UIViewController

@property BSPhotoTakeController *takeController;


- (IBAction)takePhotoOrChooseFromLibrary;
- (IBAction)takeVideoOrChooseFromLibrary;
- (IBAction)takePhotoOrVideoOrChooseFromLibrary;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) BSPhotoImagePickerController *imagePickerController;


@end
