//
//  BSImagePickerController.m
//  BSImagePicker

//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSPhotoImagePickerController.h"
#import <Photos/Photos.h>

// ViewControllers
#import "BSPhotoTakeViewController.h"

@interface BSPhotoImagePickerController ()

@property (nonatomic, strong) UINavigationController *albumsNavigationController;

@property (nonatomic, strong) NSMutableOrderedSet *selectedAssets;
@property (nonatomic, strong) NSBundle *assetBundle;

@end

@implementation BSPhotoImagePickerController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.minimumNumberOfSelection = 1;
        self.numberOfColumnsInPortrait = 4;
        self.numberOfColumnsInLandscape = 7;
        
        self.selectedAssets = [NSMutableOrderedSet orderedSet];
        
        // Get asset bundle
        self.assetBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [self.assetBundle pathForResource:@"BSImagePicker" ofType:@"bundle"];
        if (bundlePath) {
            self.assetBundle = [NSBundle bundleWithPath:bundlePath];
        }
        
        [self setUpAlbumsViewController];
        
        // Set instance
        BSPhotoTakeViewController *albumsViewController = (BSPhotoTakeViewController *)self.albumsNavigationController.topViewController;
        albumsViewController.imagePickerController = self;
    }
    
    return self;
}

- (void)setUpAlbumsViewController
{
    // Add BSAlbumsViewController as a child
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PhotoTake" bundle:self.assetBundle];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"BSPhotoTakenNavigationController"];
    
    [self addChildViewController:navigationController];
    
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    self.albumsNavigationController = navigationController;
}

@end
