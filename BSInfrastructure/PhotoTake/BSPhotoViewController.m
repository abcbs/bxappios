//
//  FDViewController.m
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSPhotoViewController.h"
#import "BSCMFrameworkHeader.h"
//#import "BSPhotoImagePickerController.h"
#import "BSPhotoTakeViewController.h"

@interface BSPhotoViewController () <BSPhotoTakeDelegate,BSImagePlayerDelegate>

@end

@implementation BSPhotoViewController
@synthesize imageView;

- (IBAction)takePhotoOrChooseFromLibrary
{
    
    [self.takeController takeSinglePhotoOrChooseFromLibrary];
}

- (IBAction)takeVideoOrChooseFromLibrary
{
    //[self.takeController takeVideoOrChooseFromLibrary];
    
    [self.takeController takeMultPhotoOrChooseFromLibrary];
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
    //[self.view addSubview:self.takeController.collectionView];
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
    BSLog(@"取消拍照动作操作");
}

- (UIViewController *)takeController:(BSPhotoTakeController *)controller{
    return self;
}

- (BOOL)isOverTakeController:(BSPhotoTakeController *)controller{
    return NO;
    
}
- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(Resources *)info
{
    
    [self.imageView setImage:photo];
}

- (void)takeController:(BSPhotoTakeController *)controller gotPhotoArray:(NSMutableArray *)photoImages withInfo:(NSMutableArray *)info{
    BSLog(@"取消拍照动作操作");
    //[self.imageView setImage:photoImages[0]];
    [self displayAD:photoImages];

}
-(void)displayAD:(NSMutableArray *)images{
    BSFCRollingADImageUIView *adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:200];
    //资源轮播
    [adView removeFromSuperview];
    [self.imageView addSubview:adView];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}


@end
