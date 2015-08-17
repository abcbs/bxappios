
/*1. 通用唯一识别码 (Universally Unique Identifier，UUID)
 *      UUID是一个128位的标志，用于将全世界的所有信标区分开来。比如星巴克在店内设置了信标，
 *  那么星巴克app可以选择只接受来自自家信标的消息，
 *      通过信标的唯一识别码星巴克app也可以判断出用户处于全球的哪一家分店，并推送相应的信息，如优惠券、连接WiFi等等。
 *
 *      iBeacon发送的正是UUID，但它只能发送这种信息。Eddystone所支持的其他框架更有用的多。
 *  UUID的缺点在于它总是和app绑定的，也就是说每一个信标需要对应的app才能发挥作用。
 *  为了解决这个问题，Eddystone支持另一种框架。
 *
 *
 *2. URL链接
 *      URL链接显然比UUID应用更广泛也更简单，任何一个手机上都有浏览器，它们都可以打开URL。
 *  虽然星巴克粉丝们不介意一直在手机中保留星巴克官方app，但一位站在冷饮售货机前的顾客显然不太想为了买一杯饮料安装一个app。
 *  在这种一次性传输中，URL无疑是最佳选择。
 *
 *      URL可以被理解成信标的二维码版本。但它相较二维码的优势在于不需要专门的二维码识别软件，也不需要顾客对着二维码拍照。
 *  有了蓝牙信标，不是顾客找链接而是链接主动找顾客。在餐馆里安放一个信标就不需要贴一百万个二维码了。
 *      谷歌曾经有一个名为The Physical Web的项目，主要工鞥就是用蓝牙信标发送URL。它和iBeacon的问题是相同的，都是只支持一种模式.
 *  Eddystone比二者都更灵活。
 *
 *
 *3. 临时标识（Ephemeral Identifiers，EDI）
 *      EID是一种安全框架，它是一种只允许被授权用户读取信息的信标。比如在公司中，大厅里安放了对全部顾客、访客广播的信标，
 *  然而公司也有只想对雇员广播的信息，他们显然不希望这些信息被顾客和访客看到。谷歌没有对这种框架做很多描述，只表示“这些信标会经常更新，
 *      只有授权的用户可以解码它们的信息”。谷歌还透露这种框架将被用于在几场找自己的行李和找自己丢失的钥匙等场景。
 *  信标技术可以告诉用户二者之间的距离。
 *
 *
 *4. 遥测数据
 *      这种框架对需要掌控大量信标的企业很有用。鉴于信标大多数使用电池供电，
 *  在一段时间后就需要更换电池或充电。遥测数据框架允许信标将自身的状态和电量信息发送给周围的IT工作人员，
 *  这样员工们可以有针对性的进行维护和更换。
 *
 */


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

static int const notify_mtu=20;
static int const  RSSI=  10;

static NSString *const  kESSddystoneCharacteristicUUID=@"08590F7E-DB05-467E-8757-72F6FAEB13D5";

static NSString *const kEddystoneServiceID = @"FEAA";

static NSString *const  kEddystoneNamespace=@"1234567890";
static NSString *const  kEddystoneServiceInstance= @"AABBCC";
static NSUInteger const  kESSEddystoneServiceIDLenght=16;

static NSString *const kESSEddystoneServiceID = @"0000FEAA-0000-1000-8000-00805F9B34FB";
/**
 * The Bluetooth Service ID for Eddystones.
 * Android定义的ServiceUUID为
 * 0000FEAA-0000-1000-8000-00805F9B34FB
 */


/**
 * Eddystones can have different frame types. Within the frames, these are (some of) the possible
 * values. See the Eddystone spec for complete details.
 */
//
/**
 * Eddystone-URL frame type value.
 * static final byte URL_FRAME_TYPE = 0x10;//苹果没有实现这种方式
 */
static const uint8_t kEddystoneUIDFrameTypeID = 0x00;
static const uint8_t kEddystoneTLMFrameTypeID = 0x20;
/**
 * struct   MYINFO
 *
 * {
 *
 *  int   a;
 *
 *  long  b;
 *
 *  char  c;
 *
 *  };
 *
 *  struct  MYINFO    infoStruct;
 *
 *  infoStruct.a = 100;
 *
 *  infoStruct.b =10000;
 *
 *  infoStruct.c = 'c';
 *
 * 1.   将   infoStruct转换为NSData
 *
 *      NSData * msgData = [[NSData alloc]
 *          initWithBytes:&infoStruct length:sizeof(infoStruct)];
 *
 * 2.  将    msgData转换为  MYINFO  对象。
 *
 *  struct  MYINFO  infoStruct2;
 *
 *  [msgData getBytes:&infoStruct2 length:sizeof(infoStruct2)];
 
 */

/**
 * 按照posix标准，一般整形对应的*_t类型为：
 *
 *      1字节     uint8_t
 *
 *      2字节     uint16_t
 *
 *      4字节     uint32_t
 *
 *      8字节     uint64_t
 *
 *  typedef signed char int8_t;
 *
 *  typedef unsigned char uint8_t;
 *
 *  typedef int int16_t;
 *
 *  typedef unsigned int uint16_t;
 *
 *  typedef long int32_t;
 *
 *  typedef unsigned long uint32_t;
 *
 *  typedef long long int64_t;
 *
 *  typedef unsigned long long uint64_t;
 *
 *  typedef int16_t intptr_t;
 *
 *  typedef uint16_t uintptr_t;

 */


// Note that for these Eddystone structures, the endianness of the individual fields is big-endian,
// so you'll want to translate back to host format when necessary.

// Eddystone结构是高端字节法则big-endian，需要翻译为主机格式

// Note that in the Eddystone spec, the beaconID (UID) is divided into 2 fields, a 10 byte namespace

// and a 6 byte instance id. However, since we ALWAYS use these in combination as a 16 byte
// beaconID, we'll have our structure here reflect that.

// Eddystone规范规定，beaconID (UID)包括两个域，10个字节的namespace，6个字节的实例ID
// 总共使用16个字节

// ESSBeaconID反应了这种结构
/*
 private byte[] buildServiceData() throws IOException {
    byte txPower = txPowerLevelToByteValue();
 
    //命名空间10个字节
    byte[] namespaceBytes = toByteArray(namespace.getText().toString());
 
    //实例的ID
    byte[] instanceBytes = toByteArray(instance.getText().toString());
 
    ByteArrayOutputStream os = new ByteArrayOutputStream();
 
    //private static final byte FRAME_TYPE_UID = 0x00;
    //txPower (byte) -16
    //1.前两个字节
    os.write(new byte[]{FRAME_TYPE_UID, txPower});
    //命名空间10个字节
    os.write(namespaceBytes);
    //实例名称6个字节
    os.write(instanceBytes);
    return os.toByteArray();
 }
 
 private void startAdvertising() {
 
    AdvertiseSettings advertiseSettings = new AdvertiseSettings.Builder()
        .setAdvertiseMode(advertiseMode)
        .setTxPowerLevel(txPowerLevel)
        .setConnectable(true)
        .build();
 
    byte[] serviceData = null;
    try {
        serviceData = buildServiceData();
    } catch (IOException e) {
 
    }
 
    AdvertiseData advertiseData = new AdvertiseData.Builder()
        .addServiceData(SERVICE_UUID, serviceData)
        .addServiceUuid(SERVICE_UUID)
        .setIncludeTxPowerLevel(false)
        .setIncludeDeviceName(false)
        .build();
 
    adv.startAdvertising(advertiseSettings, advertiseData, advertiseCallback);
 }

*/

//框架协议格式
typedef struct __attribute__((packed)) {
    uint8_t frameType;
    int8_t  txPower;//信号量在Android端为-100~20
    uint8_t zipBeaconID[16];
} ESSEddystoneUIDFrameFields;

// Test equality, ensuring that nil is equal to itself.
static inline BOOL IsEqualOrBothNil(id a, id b) {
    return ((a == b) || (a && b && [a isEqual:b]));
}

typedef NS_ENUM(NSUInteger, ESSBeaconType) {
  kESSBeaconTypeEddystone = 1,
};

typedef NS_ENUM(NSUInteger, ESSFrameType) {
  kESSEddystoneUnknownFrameType = 0,//未知类型
  kESSEddystoneUIDFrameType = 1,//通用信标UUID
  kESSEddystoneTelemetryFrameType,//遥测; 遥感勘测
};

typedef NS_ENUM(NSUInteger, ESSTxPowerType) {
    ADVERTISE_TX_POWER_HIGH = -16,//
    ADVERTISE_TX_POWER_MEDIUM = -26,//
    ADVERTISE_TX_POWER_LOW=-35,//
    ADVERTISE_TX_POWER_DEFUALT=-59
};



/**
 *=--------------------------------------------------------------=
 * ESSBeaconID
 * 包括beacon类型和beaconID
 *=--------------------------------------------------------------=
 */
@interface ESSBeaconID : NSObject <NSCopying>

/**
 * Currently there's only the Eddystone format, but we'd like to leave the door open to other
 * possibilities, so let's have a beacon type here in the info.
 *
 * Beancon的类型，目前是Eddystone，可以为其它类型，目前类型唯一类型为kESSBeaconTypeEddystone
 */
@property(nonatomic, assign, readonly) ESSBeaconType beaconType;

/**
 * The raw beaconID data.
 */
@property(nonatomic, copy, readonly) NSData *beaconID;

//LiuJQ Added for Issuse
- (instancetype)initWithType:(ESSBeaconType)beaconType
                    beaconID:(NSData *)beaconID;
@end


/**
 *=---------------------------------------------------------=
 *                   ESSBeaconInfo
 *=---------------------------------------------------------=
 */
@interface ESSBeaconInfo : NSObject

/**
 * The most recent RSSI we got for this sighting. Sometimes the OS cannot compute one reliably, so
 * this value can be null.
 */
@property(nonatomic, strong, readonly) NSNumber *RSSI;


/**
 * The beaconID for this Eddystone. All beacons have an ID.
 */
@property(nonatomic, strong, readonly) ESSBeaconID *beaconID;

/**
 * The telemetry that may or may not have been seen for this beacon. If it's set, the contents of
 * it aren't terribly relevant to us, in general. See the Eddystone spec for more information
 * if you're really interested in the exact details.
 *
 *  遥测,可能会或可能不会看到beacon。如果设置,它的内容对我们不是很相关。
 *  有关更多信息,请参见Eddystone通规范如果你真正感兴趣的具体细节。
 */
@property(nonatomic, copy, readonly) NSData *telemetry;

/**
 * Transmission power reported by beacon. This is in dB.
 *
 * beacon传输能力
 */
@property(nonatomic, strong, readonly) NSNumber *txPower;


/**
 * The scanner has seen a frame for an Eddystone. We'll need to know what type of Eddystone frame
 * it is, as there are a few types.
 *
 *Eddystone扫描的类型：类型通用信标UUID
 */
+ (ESSFrameType)frameTypeForFrame:(NSDictionary *)advFrameList;

/**
 * Given some advertisement data that we have already verified is a TLM frame (using
 * frameTypeForFrame:), return the actual telemetry data for that frame.
 *
 * 广播数据
 */
+ (NSData *)telemetryDataForFrame:(NSDictionary *)advFrameList;

/**
 * Given the service data for a frame we know to be a UID frame, an RSSI sighting,
 * and -- optionally -- telemetry data (if we've seen it), create a new ESSBeaconInfo object to
 * represent this Eddystone
 */
+ (instancetype)beaconInfoForUIDFrameData:(NSData *)UIDFrameData
                                telemetry:(NSData *)telemetry
                                     RSSI:(NSNumber *)initialRSSI;

/**
 * Convenience method to save everybody from creating these things all the time.
 */
+ (CBUUID *)eddystoneServiceID;

+ (ESSBeaconInfo *)testBeaconFromBeaconIDString:(NSString *)beaconID;

//LiuJQ Added
- (instancetype)initWithBeaconID:(ESSBeaconID *)beaconID
                         txPower:(NSNumber *)txPower
                            RSSI:(NSNumber *)RSSI
                       telemetry:(NSData *)telemetry;
@end
