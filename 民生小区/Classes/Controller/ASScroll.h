//
//  ASScroll.h
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface ASScroll : UIView<UIScrollViewDelegate>
{
    float previousTouchPoint;
    UIPageControl *pageControl;
    UIScrollView * scrollview ;
    BOOL didEndAnimate;
}
@property (strong ,nonatomic) NSArray *arrOfImages;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

-(void)initSubviews;

@end
