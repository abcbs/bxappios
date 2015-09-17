//
//  AnimatedAnnotationView.m
//  Category_demo2D
//

#import "AnimatedAnnotationView.h"
#import "AnimatedAnnotation.h"

#define kWidth          60.f
#define kHeight         60.f
#define kTimeInterval   0.15f

@implementation AnimatedAnnotationView

@synthesize imageView = _imageView;

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f, kWidth, kHeight)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - Utility

- (void)updateImageView
{
    AnimatedAnnotation *animatedAnnotation = (AnimatedAnnotation *)self.annotation;
    
    if ([self.imageView isAnimating])
    {
        [self.imageView stopAnimating];
    }
    
    self.imageView.animationImages      = animatedAnnotation.animatedImages;
    self.imageView.animationDuration    = kTimeInterval * [animatedAnnotation.animatedImages count];
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];
}

#pragma mark - Override

- (void)setAnnotation:(id<MAAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    [self updateImageView];
}

@end
