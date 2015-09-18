//
//  ScreenshotDetailViewController.m
//

#import "ScreenshotDetailViewController.h"
#import "BSUIFrameworkHeader.h"

@implementation ScreenshotDetailViewController{
    UIScrollView *scrollView;
    UIImageView *imageView;
}

#pragma mark - Handle Action

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Initialization

- (void)initImageView
{
    imageView = [[UIImageView alloc] initWithImage:self.screenshotImage];
    imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    //[self.view addSubview:imageView];
    

    [scrollView addSubview:imageView];
    
    // 设置内容范围
    scrollView.contentSize = imageView.image.size;
    
    // 设置scrollview的代理对象
    scrollView.delegate = self;
    
    // 设置最大伸缩比例
    scrollView.maximumZoomScale = 2.0;
    // 设置最小伸缩比例
    scrollView.minimumZoomScale = 0.2;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

#pragma mark 当缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scales{
    BSLog(@"scrollViewDidEndZooming");
}
#pragma mark 当正在缩放的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
   BSLog(@"scrollViewDidZoom");
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.添加UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
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
