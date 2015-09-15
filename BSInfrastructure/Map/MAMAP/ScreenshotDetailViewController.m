//
//  ScreenshotDetailViewController.m
//

#import "ScreenshotDetailViewController.h"

@implementation ScreenshotDetailViewController

#pragma mark - Handle Action

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Initialization

- (void)initImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.screenshotImage];
    imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:imageView];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)bckClick:(id)sender {
    [self backClick];
}
@end
