// Copyright 2015 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <CoreBluetooth/CoreBluetooth.h>

#import "ESSBeaconScanner.h"
#import "ESSEddystone.h"
#import "ESSTimer.h"
#import "BSIFTTHeader.h"
static const char *const kBeaconsOperationQueueName = "kESSBeaconScannerBeaconsOperationQueueName";

static NSString *const kESSEddystoneServiceID = @"FEAA";

static NSString *const kSeenCacheBeaconInfo = @"beacon_info";
static NSString *const kSeenCacheOnLostTimer = @"on_lost_timer";

/**
 *=-----------------------------------------------------------------------------------------------=
 * Private Additions to ESSBeaconScanner
 *=-----------------------------------------------------------------------------------------------=
 */
@interface ESSBeaconScanner () <CBCentralManagerDelegate> {
  CBCentralManager *_centralManager;
  dispatch_queue_t _beaconOperationsQueue;

  /**
   * This cache maps Core Bluetooth deviceIDs to NSData objects containing Eddystone telemetry.
   * Then, the next time we see a UID frame for that Eddystone, we can add the most recently seen
   * telemetry frame to the sighting.
   */
  NSMutableDictionary *_deviceIDCache;

  /**
   * Beacons we've seen already. If we see an Eddystone and notice that we've seen it before, we
   * won't fire a beaconScanner:didFindBeacon:, but instead will fire a
   * beaconScanner:didUpdateBeacon: for those listening (it's optional).
   */
  NSMutableDictionary *_seenEddystoneCache;

  BOOL _shouldBeScanning;
}

@end

/**
 *=-----------------------------------------------------------------------------------------------=
 * Implementation for ESSBeaconScanner
 *=-----------------------------------------------------------------------------------------------=
 */
@implementation ESSBeaconScanner

- (instancetype)init {
  if ((self = [super init]) != nil) {
    _onLostTimeout = 15.0;
    _deviceIDCache = [NSMutableDictionary dictionary];
    _seenEddystoneCache = [NSMutableDictionary dictionary];
    _beaconOperationsQueue = dispatch_queue_create(kBeaconsOperationQueueName, NULL);
    //中心
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                           queue:_beaconOperationsQueue];
  }

  return self;
}

#pragma mark --CBCentralManagerDelegate 中心状态更新的方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
  if (central.state == CBCentralManagerStatePoweredOn && _shouldBeScanning) {
    [self startScanning];
  }
}

// This will be called from the |beaconsOperationQueue|.
/** 3.一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：
 *This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
 *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
 *  we start the connection process
 *
 *      这个调用通知Central Manager代理（如view controller），一个附带着广播数据和信号质量
 *  (RSSI-Received Signal Strength Indicator)的周边被发现。知道了信号质量，你可以用它去判断远近。
 *  任何广播、扫描的响应数据保存在advertisementData 中，可以通过CBAdvertisementData 来访问它。
 *
 *  现在，你可以停止扫描，而去连接周边了
 */
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {

  NSDictionary *serviceData = advertisementData[CBAdvertisementDataServiceDataKey];

  // If it's a telemetry (TLM) frame, then save it into our cache so that the next time we get a
  // UID frame (i.e. an Eddystone "sighting"), we can include the telemetry with it.
  // 如果是遥感，缓存UUID
  ESSFrameType frameType = [ESSBeaconInfo frameTypeForFrame:serviceData];
  if (frameType == kESSEddystoneTelemetryFrameType) {
    _deviceIDCache[peripheral.identifier] = [ESSBeaconInfo telemetryDataForFrame:serviceData];
  } else if (frameType == kESSEddystoneUIDFrameType) {//UUID信标
    //UUID信息
    CBUUID *eddystoneServiceUUID = [ESSBeaconInfo eddystoneServiceID];
    //数据
    NSData *eddystoneServiceData = serviceData[eddystoneServiceUUID];

    // If we have telemetry data for this Eddystone, include it in the construction of the
    // ESSBeaconInfo object. Otherwise, nil is fine.
    NSData *telemetry = _deviceIDCache[peripheral.identifier];
    //获取BeaconInfo
    ESSBeaconInfo *beaconInfo = [ESSBeaconInfo beaconInfoForUIDFrameData:eddystoneServiceData
                                                               telemetry:telemetry
                                                                    RSSI:RSSI];

    if (beaconInfo != nil) {
      // NOTE: At this point you can choose whether to keep or get rid of the telemetry data. You
      //       can either opt to include it with every single beacon sighting for this beacon, or
      //       delete it until we get a new / "fresh" TLM frame. We'll treat it as "report it only
      //       when you see it", so we'll delete it each time.
      [_deviceIDCache removeObjectForKey:peripheral.identifier];

      // If we haven't seen this Eddystone before, fire a beaconScanner:didFindBeacon: and mark it
      // as seen.
      //没有获得Eddystone，调用didFindBeacon
      if (!_seenEddystoneCache[beaconInfo.beaconID]) {
        if ([_delegate respondsToSelector:@selector(beaconScanner:didFindBeacon:)]) {
          [_delegate beaconScanner:self didFindBeacon:beaconInfo];
        }
        //启动定时器
        ESSTimer *onLostTimer = [ESSTimer scheduledTimerWithDelay:_onLostTimeout
                                                          onQueue:dispatch_get_main_queue()
                                                            block:
            ^(ESSTimer *timer) {
              ESSBeaconInfo *lostBeaconInfo =
                  _seenEddystoneCache[beaconInfo.beaconID][kSeenCacheBeaconInfo];
              if (lostBeaconInfo) {
                if ([_delegate respondsToSelector:@selector(beaconScanner:didLoseBeacon:)]) {
                  [_delegate beaconScanner:self didLoseBeacon:lostBeaconInfo];
                }
                [_seenEddystoneCache removeObjectForKey:beaconInfo.beaconID];
              }
            }];
        //
        _seenEddystoneCache[beaconInfo.beaconID] = @{
            kSeenCacheBeaconInfo: beaconInfo,
            kSeenCacheOnLostTimer: onLostTimer,
        };
      } else {
        // Reset the onLost timer.
        [_seenEddystoneCache[beaconInfo.beaconID][kSeenCacheOnLostTimer] reschedule];

        // Otherwise, we've seen it, so fire a beaconScanner:didUpdateBeacon: instead.
        if ([_delegate respondsToSelector:@selector(beaconScanner:didUpdateBeacon:)]) {
          [_delegate beaconScanner:self didUpdateBeacon:beaconInfo];
        }
      }
    }
  } else {
    BSLog(@"Unsupported frame type (%d) detected. Ignorning.", (int)frameType);
  }
}


- (void)startScanning {
    dispatch_async(_beaconOperationsQueue, ^{
        if (_centralManager.state != CBCentralManagerStatePoweredOn) {
            BSLog(@"CBCentralManager state is %ld, cannot start or stop scanning",
                  (long)_centralManager.state);
            _shouldBeScanning = YES;
        } else {
            BSLog(@"Starting to scan for Eddystones");
            NSArray *services = @[
                                  [CBUUID UUIDWithString:kESSEddystoneServiceID]
                                  ];
            
            // We do not want multiple discoveries of the same beacon to be coalesced into one.
            // (Unfortunately this is ignored when we are in the background.)
            NSDictionary *options = @{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES };
            //查找服务
            [_centralManager scanForPeripheralsWithServices:services options:options];
        }
    });
}

- (void)stopScanning {
    _shouldBeScanning = NO;
    [_centralManager stopScan];
    [self clearRemainingTimers];
}

- (void)clearRemainingTimers {
  for (ESSBeaconID *beaconID in _seenEddystoneCache) {
    [_seenEddystoneCache[beaconID][kSeenCacheOnLostTimer] cancel];
  }

  _seenEddystoneCache = nil;
}

@end
