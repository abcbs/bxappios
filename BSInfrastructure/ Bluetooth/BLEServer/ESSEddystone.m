
#import "ESSEddystone.h"

#import <CoreBluetooth/CoreBluetooth.h>
/**
 *=---------------------------------------------------------=
 *             ESSBeaconID
 *=---------------------------------------------------------=
 */
@implementation ESSBeaconID

/**
 * This property is orginally declared in a superclass (NSObject), so cannot be auto-synthesized.
 */
@synthesize hash = _hash;

- (instancetype)initWithType:(ESSBeaconType)beaconType
                    beaconID:(NSData *)beaconID {
  self = [super init];
  if (self) {
    _beaconType = beaconType;
    _beaconID = [beaconID copy];
    _hash = 31 * self.beaconType + [self.beaconID hash];
  }
  return self;
}

/**
 * So that whenever you convert this to a string, you get something useful.
 */
- (NSString *)description {
  if (self.beaconType == kESSBeaconTypeEddystone) {
    return [NSString stringWithFormat:@"ESSBeaconID: beaconID=%@", self.beaconID];
  } else {
    return [NSString stringWithFormat:@"ESSBeaconID with invalid type %lu",
        (unsigned long)self.beaconType];
  }
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  }
  if (!self
      || !object
      || !([self isKindOfClass:[object class]] || [object isKindOfClass:[self class]])) {
    return NO;
  }

  ESSBeaconID *other = (ESSBeaconID *)object;
  return ((self.beaconType == other.beaconType) &&
          IsEqualOrBothNil(self.beaconID, other.beaconID));
}

- (id)copyWithZone:(NSZone *)zone {
  // Immutable object: 'copy' by reusing the same instance.
  return self;
}

@end
/**
 *=------------------ESSBeaconID定义结束-------------------=
 */

/**
 *=--------------------------------------------------------=
 *                    ESSBeaconInfo
 *=--------------------------------------------------------=
 */
@implementation ESSBeaconInfo

/**
 * Given the advertising frames from CoreBluetooth for a device with the Eddystone Service ID,
 * figure out what type of frame it is.
 *
 * 根据设备得服务ID从广告信息中获取信息的种类
 */
+ (ESSFrameType)frameTypeForFrame:(NSDictionary *)advFrameList {
  // 根据Service的ID获取框架数据
  NSData *frameData = advFrameList[[self eddystoneServiceID]];

  // It's an Eddystone ADV frame. Now check if it's a UID (ID) or TLM (telemetry) frame.
  //获取到广告数据，
  if (frameData) {//框架数据
    uint8_t frameType;
    //框架类型
    if ([frameData length] > 1) {
      frameType = ((uint8_t *)[frameData bytes])[0];

      if (frameType == kEddystoneUIDFrameTypeID) {
        return kESSEddystoneUIDFrameType;
      } else if (frameType == kEddystoneTLMFrameTypeID) {
        return kESSEddystoneTelemetryFrameType;
      }
    }
  }

  return kESSEddystoneUnknownFrameType;
}

+ (NSData *)telemetryDataForFrame:(NSDictionary *)advFrameList {
  // NOTE: We assume that you've already called [ESSBeaconInfo frameTypeForFrame] to confirm that
  //       this actually IS a telemetry frame.
  NSAssert([ESSBeaconInfo frameTypeForFrame:advFrameList] == kESSEddystoneTelemetryFrameType,
           @"This should be a TLM frame, but it's not. Whooops");
  return advFrameList[[self eddystoneServiceID]];
}

- (instancetype)initWithBeaconID:(ESSBeaconID *)beaconID
                         txPower:(NSNumber *)txPower
                            RSSI:(NSNumber *)RSSI
                       telemetry:(NSData *)telemetry {
  if ((self = [super init]) != nil) {
    _beaconID = beaconID;
    _txPower = txPower;
    _RSSI = RSSI;
    _telemetry = [telemetry copy];
  }

  return self;
}

+ (instancetype)beaconInfoForUIDFrameData:(NSData *)UIDFrameData
                                telemetry:(NSData *)telemetry
                                     RSSI:(NSNumber *)RSSI {
  // Make sure this frame has the correct frame type identifier
  //无符号
  uint8_t frameType;
  [UIDFrameData getBytes:&frameType length:1];
  if (frameType != kEddystoneUIDFrameTypeID) {
    return nil;
  }

  ESSEddystoneUIDFrameFields uidFrame;

  if ([UIDFrameData length] != sizeof(ESSEddystoneUIDFrameFields)) {
    return nil;
  }
  [UIDFrameData getBytes:&uidFrame length:sizeof(ESSEddystoneUIDFrameFields)];

  NSData *beaconIDData = [NSData dataWithBytes:&uidFrame.zipBeaconID
                                        length:sizeof(uidFrame.zipBeaconID)];
    
  ESSBeaconID *beaconID = [[ESSBeaconID alloc] initWithType:kESSBeaconTypeEddystone
      beaconID:beaconIDData];
  if (beaconID == nil) {
    return nil;
  }

  return [[ESSBeaconInfo alloc] initWithBeaconID:beaconID
                                         txPower:@(uidFrame.txPower)
                                            RSSI:RSSI
                                       telemetry:telemetry];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Eddystone, id: %@, RSSI: %@, txPower: %@",
      _beaconID, _RSSI, _txPower];
}

/**
 *  尽管这是单例的实际定义，但在Foundation框架中不一定是这样。
 *  比如NSFileManger和NSNotificationCenter，分别通过它们的类方法defaultManager和defaultCenter获取。
 *  尽管不是严格意义的单例，这些类方法返回一个可以在应用的所有代码中访问到的类的共享实例。
 *
 *  在本文中我们也会采用该方法,用于实现单例模式的函数。
 *      该函数就是dispatch_once：
 *      void dispatch_once( dispatch_once_t *predicate, dispatch_block_t block);
 *      该函数接收一个dispatch_once用于检查该代码块是否已经被调度的谓词（是一个长整型，实际上作为BOOL使用）。
 *      它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
 *      dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，
 *      这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
 *
 *
 *  服务的CBUUID的单例
 */
+ (CBUUID *)eddystoneServiceID {
  static CBUUID *_singleton;
  static dispatch_once_t oncePredicate;

  dispatch_once(&oncePredicate, ^{
    _singleton = [CBUUID UUIDWithString:kESSEddystoneServiceID];
  });

  return _singleton;
}

+ (ESSBeaconInfo *)testBeaconFromBeaconIDString:(NSString *)beaconID {

  NSData *beaconIDData = [ESSBeaconInfo hexStringToNSData:beaconID];

  ESSBeaconID *beaconIDObj = [[ESSBeaconID alloc] initWithType:kESSBeaconTypeEddystone
                                                      beaconID:beaconIDData];
  return [[ESSBeaconInfo alloc] initWithBeaconID:beaconIDObj
                                         txPower:@(-20)
                                            RSSI:@(-100)
                                       telemetry:nil];
}

+ (NSData *)hexStringToNSData:(NSString *)hexString {
  NSMutableData *data = [[NSMutableData alloc] init];
  unsigned char whole_byte;
  char byte_chars[3] = {'\0','\0','\0'};

  int i;
  for (i = 0; i < [hexString length]/2; i++) {
    byte_chars[0] = [hexString characterAtIndex:i * 2];
    byte_chars[1] = [hexString characterAtIndex:i * 2 + 1];
    whole_byte = strtol(byte_chars, NULL, 16);
    [data appendBytes:&whole_byte length:1];
  }

  return data;
}

@end
