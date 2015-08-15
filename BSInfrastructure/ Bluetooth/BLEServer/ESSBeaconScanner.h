//

#import <Foundation/Foundation.h>

@class ESSBeaconScanner;

// Delegates to the ESSBeaconScanner should implement this protocol.
@protocol ESSBeaconScannerDelegate <NSObject>

@optional

- (void)beaconScanner:(ESSBeaconScanner *)scanner
        didFindBeacon:(id)beaconInfo;
- (void)beaconScanner:(ESSBeaconScanner *)scanner
        didLoseBeacon:(id)beaconInfo;

- (void)beaconScanner:(ESSBeaconScanner *)scanner
      didUpdateBeacon:(id)beaconInfo;

@end

@interface ESSBeaconScanner : NSObject

@property(nonatomic, weak) id<ESSBeaconScannerDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval onLostTimeout;

- (void)startScanning;
- (void)stopScanning;

@end
