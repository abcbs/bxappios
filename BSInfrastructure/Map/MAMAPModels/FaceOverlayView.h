//
//  FaceOverlayView.h
//

#import <MAMapKit/MAOverlayPathView.h>
#import "FaceOverlay.h"

@interface FaceOverlayView : MAOverlayPathView

- (id)initWithFaceOverlay:(FaceOverlay *)faceOverlay;

@property (nonatomic, readonly) FaceOverlay *faceOverlay;

@end
