//
//  FDViewController.m
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSPhotoViewController.h"

@interface BSPhotoViewController () <BSPhotoTakeDelegate>

@end

@implementation BSPhotoViewController
@synthesize imageView;

- (IBAction)takePhotoOrChooseFromLibrary
{
    [self.takeController takePhotoOrChooseFromLibrary];
}

- (IBAction)takeVideoOrChooseFromLibrary
{
    [self.takeController takeVideoOrChooseFromLibrary];
}

- (IBAction)takePhotoOrVideoOrChooseFromLibrary
{
    [self.takeController takePhotoOrVideoOrChooseFromLibrary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.takeController = [[BSPhotoTakeController alloc] init];
    self.takeController.delegate = self;
    
    NSBundle* myBundle = [NSBundle bundleWithIdentifier:@"BSTakeTranslations"];
    NSLog(@"%@", myBundle);
    NSString *str = NSLocalizedStringFromTableInBundle(@"noSources",
                                                       nil,
                                                       [NSBundle bundleWithIdentifier:@"BSTakeTranslations"],
                                                       @"There are no sources available to select a photo");
    NSLog(@"%@", str);
    
}


#pragma mark - FDTakeDelegate

- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    UIAlertView *alertView;
    if (madeAttempt)
        alertView = [[UIAlertView alloc] initWithTitle:@"Example app" message:@"The take was cancelled after selecting media" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    else
        alertView = [[UIAlertView alloc] initWithTitle:@"Example app" message:@"The take was cancelled without selecting media" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [self.imageView setImage:photo];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
