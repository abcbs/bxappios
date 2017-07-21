#import <UIKit/UIKit.h>

@interface BSNetworkNotify :NSObject

@property (nonatomic) NSString *remoteHostName;

+ (BSNetworkNotify *)sharedBSNetworkNotify;


- ( void ) startNetworkReachability;
-  ( void ) stopNetworkReachability;

-  ( NSString * ) currentNetworkReachability;
//4G/wifi/nonet
-(NSString *) currentNetworkType;

-(void) networkTimeOut;
-(void) networkRunning;

@end
