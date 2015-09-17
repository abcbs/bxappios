//
//  MANaviAnnotationView.h
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CLLocation.h>

@interface MANaviAnnotationView : MAPinAnnotationView

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface NaviButton : UIButton

@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UILabel *naviLabel;

@end
