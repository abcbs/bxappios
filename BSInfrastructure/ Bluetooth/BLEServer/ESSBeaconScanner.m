//

#import <CoreBluetooth/CoreBluetooth.h>

#import "ESSBeaconScanner.h"
#import "ESSEddystone.h"
#import "ESSTimer.h"
#import "BSIFTTHeader.h"

static const char *const kBeaconsOperationQueueName = "kESSBeaconScannerBeaconsOperationQueueName";



static NSString *const kSeenCacheBeaconInfo = @"beacon_info";
static NSString *const kSeenCacheOnLostTimer = @"on_lost_timer";

/**
 *=------------------------------------------------------=
 * Private Additions to ESSBeaconScanner
 *=------------------------------------------------------=
 */
@interface ESSBeaconScanner () <CBCentralManagerDelegate> {
  //
  CBCentralManager *_centralManager;
  //定义分发队列
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
   * 
   *    已经发现的Beacon,在发现Eddystone之前，不能调用beaconScanner:didFindBeacon
   * 但可以调用
   * beaconScanner:didUpdateBeacon
   */
  NSMutableDictionary *_seenEddystoneCache;

  BOOL _shouldBeScanning;
}

@end

/**
 *=----------------------------------------------------=
 * Implementation for ESSBeaconScanner
 *=----------------------------------------------------=
 */
@implementation ESSBeaconScanner

/**
 *  三种多线程技术的对比
 *  1.NSThread:每个NSThread对象对应一个线程，量级较轻（真正的多线程）
 *  –优点：NSThread 比其他两个轻量级，使用简单
 *  –缺点：需要自己管理线程的生命周期、线程同步、加锁、睡眠以及唤醒等。
 *      线程同步对数据的加锁会有一定的系统开销
 *
 *  2.NSOperation：NSOperation/NSOperationQueue 面向对象的线程技术
 *  –不需要关心线程管理，数据同步的事情，可以把精力放在自己需要执行的操作上
 *   –NSOperation是面向对象的
 *
 *  3.GCD：Grand Central Dispatch（派发） 是基于C语言的框架，可以充分利用多核，
 *      是苹果推荐使用的多线程技术
 *  –Grand Central Dispatch是由苹果开发的一个多核编程的解决方案。
 *      iOS4.0+才能使用，是替代NSThread， NSOperation的高效和强大的技术
 *  –GCD是基于C语言的
 *
 *  Dispatch Queues
 *      GCD的基本概念就是dispatch queue。dispatch queue是一个对象，它可以接受任务，
 *  并将任务以先到先执行的顺序来执行。dispatch queue可以是并发的或串行的。并发任务会像
 *  NSOperationQueue那样基于系统负载来合适地并发进行，串行队列同一时间只执行单一任务。
 *  
 *  3.1.The main queue:
 *  与主线程功能相同。实际上，提交至main queue的任务会在主线程中执行。
 *  main queue可以调用dispatch_get_main_queue()来获得。
 *  因为main queue是与主线程相关的，所以这是一个串行队列。
 *
 *  3.2.Global queues: 全局队列是并发队列，并由整个进程共享。
 *  进程中存在三个全局队列：高、中（默认）、低三个优先级队列。
 *  可以调用dispatch_get_global_queue函数传入优先级来访问队列。
 *
 *  3.3.用户队列: 用户队列 (GCD并不这样称呼这种队列, 但是没有一个特定的名字来形容这种队列，
 *  所以我们称其为用户队列) 是用函数 dispatch_queue_create 创建的队列. 这些队列是串行的。
 *  正因为如此，它们可以用来完成同步机制, 有点像传统线程中的mutex。
 *  
 *  官网文档解释说共有三个并发队列，但实际还有一个更低优先级的队列，设置优先级为
 *  DISPATCH_QUEUE_PRIORITY_BACKGROUND。Xcode调试时可以观察到正在使用的各个dispatch队列。
 */
- (instancetype)init {
  if ((self = [super init]) != nil) {
    _onLostTimeout = 15.0;
    _deviceIDCache = [NSMutableDictionary dictionary];
    _seenEddystoneCache = [NSMutableDictionary dictionary];
      
    /**
     *  dispatch_queue_create(const char *label, dispatch_queue_attr_t attr);
     *  生成队列的三种方式
     *  1.queue = dispatch_queue_create("com.dispatch.serial", DISPATCH_QUEUE_SERIAL);
     *  生成一个串行队列，队列中的block按照先进先出（FIFO）的顺序去执行，实际上为单线程执行。
     *  第一个参数是队列的名称，在调试程序时会非常有用，所有尽量不要重名了。
     *
     *  2.dispatch_queue_t queue = dispatch_queue_create("com.dispatch.concurrent", DISPATCH_QUEUE_CONCURRENT);
     *  生成一个并发执行队列，block被分发到多个线程去执行
     *
     *  3.dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); 
     *  获得程序进程缺省产生的并发队列，可设定优先级来选择高、中、低三个优先级队列。
     *  由于是系统默认生成的，所以无法调用dispatch_resume()和dispatch_suspend()来控制执行继续或中断。
     *  需要注意的是，三个队列不代表三个线程，可能会有更多的线程。
     *  并发队列可以根据实际情况来自动产生合理的线程数，也可理解为dispatch队列实现了一个线程池的管理，对于程序逻辑是透明的。
     *
     *  4. dispatch_queue_t queue = dispatch_get_main_queue(); 
     *  获得主线程的dispatch队列，实际是一个串行队列。同样无法控制主线程dispatch队列的执行继续或中断。
     */
    //创建一个自定义的串行队列,队列的属性被保留供将来使用，应该为NULL
    _beaconOperationsQueue =
      dispatch_queue_create(kBeaconsOperationQueueName, NULL);
      
      
    //1.创建中心
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                           queue:_beaconOperationsQueue];
  }

  return self;
}

#pragma mark --CBCentralManagerDelegate 中心状态更新的方法

/**
 *  2.当Central Manager被初始化，我们要检查它的状态，以检查运行这个App的设备是不是支持BLE。
 */
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
  //获取具体的数据，key是CBUUID
  //A dictionary containing service-specific advertisement data. Keys are CBUUID
  //根据服务得CBUUID获取服务得数据， Key为CBUUID，其数据是Service
  NSDictionary *serviceData = advertisementData[CBAdvertisementDataServiceDataKey];

  // If it's a telemetry (TLM) frame, then save it into our cache so that the next time we get a
  // UID frame (i.e. an Eddystone "sighting"), we can include the telemetry with it.
  // 如果是遥感，缓存UUID
  //如果是遥测(TLM)框架,然后保存到缓存中,这样下次我们得到一个UID框架(即一个Eddystone“照准”),我们可以包括遥测。
  ESSFrameType frameType = [ESSBeaconInfo frameTypeForFrame:serviceData];
  
  //Eddyestone如果是遥感类型
  if (frameType == kESSEddystoneTelemetryFrameType) {//
    _deviceIDCache[peripheral.identifier] = [ESSBeaconInfo telemetryDataForFrame:serviceData];
  } else if (frameType == kESSEddystoneUIDFrameType) {//UUID信标
    //UUID信息
    CBUUID *eddystoneServiceUUID = [ESSBeaconInfo eddystoneServiceID];
    //数据
    NSData *eddystoneServiceData = serviceData[eddystoneServiceUUID];

    // If we have telemetry data for this Eddystone, include it in the construction of the
    // ESSBeaconInfo object. Otherwise, nil is fine.
    //如果获得Eddystone的遥感数据,包括构建ESSBeaconInfo对象。否则,为nil。
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
      //
      [_deviceIDCache removeObjectForKey:peripheral.identifier];

      // If we haven't seen this Eddystone before, fire a beaconScanner:didFindBeacon: and mark it
      // as seen.
      // 没有获得Eddystone，调用didFindBeacon
      if (!_seenEddystoneCache[beaconInfo.beaconID]) {//首次发现服务，则执行定时
        if ([_delegate respondsToSelector:@selector(beaconScanner:didFindBeacon:)]) {
          //
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
      } else {//_seenEddystoneCache存在
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
    /**
     *  使用dispatch_async或dispatch_sync函数来加载需要运行的block。
     *  同步执行，同步执行block，函数不返回，一直等到block执行完毕。
     *  编译器会根据实际情况优化代码，所以有时候你会发现block其实还在当前线程上执行，并没用产生新线程。
     *  实际编程经验告诉我们，尽可能避免使用dispatch_sync，嵌套使用时还容易引起程序死锁。
     *  dispatch_sync(queue, ^{
     *
     *　　//block具体代码
     *
     *  });
     *
     *  异步执行block，函数立即返回
     */
    dispatch_async(_beaconOperationsQueue, ^{
        if (_centralManager.state != CBCentralManagerStatePoweredOn) {
            BSLog(@"CBCentralManager state is %ld, cannot start or stop scanning",
                  (long)_centralManager.state);
            _shouldBeScanning = YES;//当没有搜索到信标时，应当继续搜索
        } else {
            BSLog(@"Starting to scan for Eddystones");
            NSArray *services = @[
                                  [CBUUID UUIDWithString:kESSEddystoneServiceID]
                                  ];
            
            // We do not want multiple discoveries of the same beacon to be coalesced into one.
            // (Unfortunately this is ignored when we are in the background.)
            //我们不希望重复得发现同一个beacon。(当我们在后台运行时 ，这个特性被忽略)。
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
