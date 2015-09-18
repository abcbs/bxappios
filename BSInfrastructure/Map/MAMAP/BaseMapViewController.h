//
//  BaseMapViewController.h
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "BSUICommonController.h"
#import "BSIFTTHeader.h"

@interface BaseMapViewController : BSUICommonController<MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MAMapView *mapView;


- (void)clearResource;
- (void)clearMapData;

- (NSString *)getApplicationName;
- (NSString *)getApplicationScheme;
- (void)initMapView;

@end
