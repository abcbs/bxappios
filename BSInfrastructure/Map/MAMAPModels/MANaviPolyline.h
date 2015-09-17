//
//  MANaviPolyline.h
//

#import <MAMapKit/MAPolyline.h>
#import "MANaviAnnotation.h"

@interface MANaviPolyline : NSObject<MAOverlay>

@property (nonatomic, assign) MANaviAnnotationType type;
@property (nonatomic, strong) MAPolyline *polyline;

- (id)initWithPolyline:(MAPolyline *)polyline;

@end
