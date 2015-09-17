//
//  MANaviAnnotation.h
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

typedef NS_ENUM(NSInteger, MANaviAnnotationType)
{
    MANaviAnnotationTypeDrive = 0,
    MANaviAnnotationTypeWalking = 1,
    MANaviAnnotationTypeBus = 2
};

@interface MANaviAnnotation : MAPointAnnotation

@property (nonatomic) MANaviAnnotationType type;

@end
