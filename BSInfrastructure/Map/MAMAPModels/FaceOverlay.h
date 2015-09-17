//
//  FaceOverlay.h
//

#import <MAMapKit/MAMapKit.h>

@interface FaceOverlay : MAShape<MAOverlay>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly) MAMapRect boundingMapRect;

+ (id)faceWithLeftEyeCoordinate:(CLLocationCoordinate2D)leftEyeCoordinate
                  leftEyeRadius:(CLLocationDistance)leftEyeRadius
             rightEyeCoordinate:(CLLocationCoordinate2D)rightEyeCoordinate
                 rightEyeRadius:(CLLocationDistance)rightEyeRadius;

@property (nonatomic, readonly) CLLocationCoordinate2D leftEyeCoordinate;
@property (nonatomic, readonly) CLLocationCoordinate2D rightEyeCoordinate;
@property (nonatomic, readonly) CLLocationDistance leftEyeRadius;
@property (nonatomic, readonly) CLLocationDistance rightEyeRadius;

@end
