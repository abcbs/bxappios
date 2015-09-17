//
//  RouteDetailViewController.h
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface RouteDetailViewController : UIViewController

@property (nonatomic, strong) AMapRoute *route;

@property (nonatomic) AMapSearchType searchType;

@end
