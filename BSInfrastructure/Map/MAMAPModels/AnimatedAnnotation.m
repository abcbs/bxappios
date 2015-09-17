//
//  AnimatedAnnotation.m
//

#import "AnimatedAnnotation.h"

@implementation AnimatedAnnotation

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;

@synthesize animatedImages = _animatedImages;

#pragma mark - life cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
    }
    return self;
}

@end
