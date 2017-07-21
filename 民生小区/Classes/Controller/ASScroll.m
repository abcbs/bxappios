//
//  ASScroll.m
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23.
//
//

#import "ASScroll.h"

@implementation ASScroll

@synthesize arrOfImages;
@synthesize leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)initSubviews
{
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(self.bounds.size.width*2/5,self.bounds.size.height/11*9, self.bounds.size.width/5, self.bounds.size.height/11*2);
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
   // pageControl.pageIndicatorTintColor = LightGrayColor;
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height/11*9)];
    [scrollview setDelegate:self];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.pagingEnabled = YES;//整页的滑动
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self addGestureRecognizer:self.rightSwipeGestureRecognizer];
    [self addSubview:scrollview];
    [self addSubview:pageControl];
}

-(void)setArrOfImages:(NSArray *)arr{
    
    UIImageView *defaultImage;
    if (arr==nil || arr.count==0) {
        defaultImage = [[UIImageView alloc]init];
        defaultImage.contentMode=UIViewContentModeScaleAspectFit;
        defaultImage.frame = CGRectMake(0.0, 0.0,self.bounds.size.width , self.bounds.size.height/11*9);
        defaultImage.image=[UIImage imageNamed:@"img_01"] ;
        [scrollview addSubview:defaultImage];
        return;
    }
    
    NSArray* scSubvs=[scrollview subviews];
    if (scSubvs!=nil) {
        for (UIView* sv in scSubvs) {
            [sv removeFromSuperview];
        }
    }
    arrOfImages=[arr copy];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = arrOfImages.count;
   
    
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * arrOfImages.count,scrollview.frame.size.height);
    
   
    for (int i =0; i<arrOfImages.count ; i++) {
       UIImageView * imageview = [[UIImageView alloc]init];
        imageview.frame = CGRectMake(i*(scrollview.frame.size.width), 0.0,scrollview.frame.size.width, scrollview.frame.size.height);
        NSDictionary *dic =arrOfImages[i];
        if([[dic objectForKey:@"Photo" ] isEqualToString:@""])
        {
            imageview.image=[UIImage imageNamed:@"img_01"] ;
        }
        else
        {
            [imageview sd_setImageWithURL:[dic objectForKey:@"Photo" ] placeholderImage:[UIImage imageNamed:@"img_01"] options:SDWebImageDelayPlaceholder];
        }
        [scrollview addSubview:imageview];
    }
   
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft && pageControl.currentPage>0) {
        [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage -1)%arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
         [pageControl setCurrentPage:((pageControl.currentPage -1)%arrOfImages.count)];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage +1)%arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
         [pageControl setCurrentPage:((pageControl.currentPage +1)%arrOfImages.count)];
    }
}

- (void)startAnimatingScrl
{
    if (arrOfImages.count) {
        [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage +1)%arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
        [pageControl setCurrentPage:((pageControl.currentPage +1)%arrOfImages.count)];
    }
}
-(void) cancelScrollAnimation{
    didEndAnimate =YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimatingScrl) object:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    previousTouchPoint = scrollView.contentOffset.x;
}
//
- (IBAction)pgCntlChanged:(UIPageControl *)sender {
    [scrollview scrollRectToVisible:CGRectMake(sender.currentPage*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
    [self cancelScrollAnimation];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [pageControl setCurrentPage:scrollview.bounds.origin.x/scrollview.frame.size.width];
    [self cancelScrollAnimation];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    int page = floor((scrollView.contentOffset.x - scrollview.frame.size.width) / scrollview.frame.size.width) + 1;
    
    if (previousTouchPoint > scrollView.contentOffset.x)
        page = page+2;
    else
        page = page+1;
}

@end
