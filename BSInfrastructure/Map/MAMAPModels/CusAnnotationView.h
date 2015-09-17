//
//  CusAnnotationView.h
//

#import <MAMapKit/MAMapKit.h>

@interface CusAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

@end
