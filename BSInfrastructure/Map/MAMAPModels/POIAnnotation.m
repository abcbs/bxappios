//
//  POIAnnotation.m
//

#import "POIAnnotation.h"

@interface POIAnnotation ()

@property (nonatomic, readwrite, strong) AMapPOI *poi;

@end

@implementation POIAnnotation
@synthesize poi = _poi;

#pragma mark - MAAnnotation Protocol

- (NSString *)title
{
    return self.poi.name;
}

- (NSString *)subtitle
{
    return self.poi.address;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.poi.location.latitude, self.poi.location.longitude);
}

#pragma mark - Life Cycle

- (id)initWithPOI:(AMapPOI *)poi
{
    if (self = [super init])
    {
        self.poi = poi;
    }
    
    return self;
}

@end
