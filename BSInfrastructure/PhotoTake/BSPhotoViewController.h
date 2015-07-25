//
//  FDViewController.h
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "BSPhotoTakeController.h"

@interface BSPhotoViewController : UIViewController

@property BSPhotoTakeController *takeController;
- (IBAction)takePhotoOrChooseFromLibrary;
- (IBAction)takeVideoOrChooseFromLibrary;
- (IBAction)takePhotoOrVideoOrChooseFromLibrary;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
