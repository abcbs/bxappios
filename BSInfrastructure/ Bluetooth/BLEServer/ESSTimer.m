//

#import "ESSTimer.h"

/**
 *=------------------------------------------------=
 * Private Additions to ESSTimer
 *=------------------------------------------------=
 */
@interface ESSTimer ()

@property(nonatomic, copy, readwrite) ESSTimerBlock block;
@property(nonatomic, copy, readwrite) void(^wrappedBlock)();

@property(nonatomic, strong, readwrite) dispatch_queue_t queue;
@property(nonatomic, assign, readwrite) NSTimeInterval delay;

// The dispatch source used for the timer.
/**
 *      所有定时器dispatch source都是间隔定时器，一旦创建，会按你指定的间隔定期递送事件。
 *  你需要为定时器dispatch source指定一个期望的定时器事件精度，也就是leeway值，让系统能够灵活地管理电源并唤醒内核。
 *  例如系统可以使用leeway值来提前或延迟触发定时器，使其更好地与其它系统事件结合。创建自己的定时器时，你应该尽量指定一个leeway值。
 *  就算你指定leeway值为0，也不要期望定时器能够按照精确的纳秒来触发事件。系统会尽可能地满足你的需求，但是无法保证完全精确的触发时间。
 *
 *      当计算机睡眠时，定时器dispatch source会被挂起，稍后系统唤醒时，定时器dispatch source也会自动唤醒。
 *  根据你提供的配置，暂停定时器可能会影响定时器下一次的触发。如果定时器dispatch source使用 dispatch_time 函数
 *  或 DISPATCH_TIME_NOW 常量设置，定时器dispatch source会使用系统默认时钟来确定何时触发，但是默认时钟在计算机睡眠时不会继续。
 *  如果你使用 dispatch_walltime 函数来设置定时器dispatch source，则定时器会根据挂钟时间来跟踪，
 *  这种定时器比较适合触发间隔相对比较大的场合，可以防止定时器触发间隔出现太大的误差。
 *
 */
@property(nonatomic, strong, readwrite) dispatch_source_t source;

@property(nonatomic, assign) BOOL suspended;

@end

/**
 *=----------------------------------------------------=
 * Implementation for ESSTimer
 *=----------------------------------------------------=
 */
@implementation ESSTimer

- (ESSTimer *)initWithDelay:(NSTimeInterval)delay
                    onQueue:(dispatch_queue_t)queue
                      block:(ESSTimerBlock)block {
  self = [super init];
  if (self) {
    _block = block;
    _queue = queue;
    _delay = delay;

    __block ESSTimer *blockSelf = self;

    _wrappedBlock = ^{
      // This is a one-shot timer - ensure we don't call its block after it has been canceled.
      if (!dispatch_source_testcancel(blockSelf.source)) {
        dispatch_source_cancel(blockSelf.source);
        blockSelf.block(blockSelf);
      }
    };
   
    /*
     *
     */
    _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
  }
  return self;
}

+ (ESSTimer *)timerWithDelay:(NSTimeInterval)delay
                     onQueue:(dispatch_queue_t)queue
                       block:(ESSTimerBlock)block {
  return [[self alloc] initWithDelay:delay onQueue:queue block:block];

}

+ (ESSTimer *)scheduledTimerWithDelay:(NSTimeInterval)delay
                              onQueue:(dispatch_queue_t)queue
                                block:(ESSTimerBlock)block {
  ESSTimer *timer = [self timerWithDelay:delay onQueue:queue block:block];
  [timer schedule];
  return timer;
}

- (void)schedule {
  [self reschedule];
  /**
   *        你需要定义一个事件处理器来处理事件，可以是函数或block对象，并使用 dispatch_source_set_event_handler
   *    或 dispatch_source_set_event_handler_f 安装事件处理器。
   *    事件到达时，dispatch source会提交你的事件处理器到指定的dispatch queue，由queue执行事件处理器。
  */
  dispatch_source_set_event_handler(_source, _wrappedBlock);
  //
  dispatch_resume(_source);
}

- (void)reschedule {
  /*
   *        获取一个dispatch_time_t类型的值可以通过两种方式来获取，以上是第一种方式，即通过dispatch_time函数，
   *    另一种是通过dispatch_walltime函数来获取，dispatch_walltime需要使用一个timespec的结构体来得到dispatch_time_t。
   *    通常dispatch_time用于计算相对时间，dispatch_walltime用于计算绝对时间，
   */
  //NSEC_PER_SEC表示的是秒数，它还提供了NSEC_PER_MSEC表示毫秒。
  dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC));
    
  // Leeway is 10% of timer delay
  //对于定时器源，使用 dispatch_source_set_timer 函数设置定时器信息.
  //定时器dispatch source的一个例子，每30秒触发一次，leeway值为1，
  //因为间隔相对较大，使用 dispatch_walltime 来创建定时器。定时器会立即触发第一次，随后每30秒触发一次。
  //dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
  dispatch_source_set_timer(_source, start, DISPATCH_TIME_FOREVER,
                            (uint64_t)(_delay / 10) * NSEC_PER_SEC);
}

/**
 *      暂停一个队列
 *      如果需要暂停一个队列，可以调用如下代码。暂停一个队列会阻止和该队列相关的所有代码运行。
 *      dispatch_suspend(myQueue);
 *
 *      恢复一个队列
 *      如果暂停一个队列不要忘记恢复。
 *      暂停和恢复的操作和内存管理中的retain和release类似。调用dispatch_suspend会增加暂停计数，而dispatch_resume则会减少。
 *  队列只有在暂停计数变成零的情况下才开始运行。dispatch_resume(myQueue);
 *
 *      从队列中在主线程运行代码
 *      有些操作无法在异步队列运行，因此必须在主线程（每个应用都有一个）上运行。
 *  UI绘图以及任何对NSNotificationCenter的调用必须在主线程长进行。
 *  在另一个队列中访问主线程并运行代码的示例如下：
 *      dispatch_sync(dispatch_get_main_queue(), ^{ [self dismissLoginWindow]; });
 *  注意，dispatch_suspend （以及dispatch_resume）在主线程上不起作用。
 */
- (void)suspend {
  dispatch_suspend(_source);
}

- (void)resume {
  dispatch_resume(_source);
}

- (void)cancel {
  dispatch_source_cancel(_source);
}

@end
