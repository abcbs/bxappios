//
//ESSTimer
//
//
/**
 *  Dispatch Sources
 *  现代系统通常提供异步接口，允许应用向系统提交请求，然后在系统处理请求时应用可以继续处理自己的事情。
 *  Grand Central Dispatch正是基于这个基本行为而设计，允许你提交请求，并通过block和dispatch queue报告结果。
 *  
 *  dispatch source是基础数据类型，协调特定底层系统事件的处理。Grand Central Dispatch支持以下dispatch source：
 *      Timer dispatch source：定期产生通知
 *
 *      Signal dispatch source：UNIX信号到达时产生通知
 *
 *      Descriptor dispatch source：各种文件和socket操作的通知
 *          数据可读
 *          数据可写
 *          文件在文件系统中被删除、移动、重命名
 *          文件元数据信息改变
 *
 *      Process dispatch source：进程相关的事件通知
 *          当进程退出时
 *          当进程发起fork或exec等调用
 *          信号被递送到进程
 *
 *      Mach port dispatch source：Mach相关事件的通知
 *
 *      Custom dispatch source：你自己定义并自己触发
 *
 *      Dispatch source替代了异步回调函数，来处理系统相关的事件。
 *  当你配置一个dispatch source时，你指定要监测的事件、dispatch queue、以及处理事件的代码(block或函数)。
 *  当事件发生时，dispatch source会提交你的block或函数到指定的queue去执行。
 *
 *  和手工提交到queue的任务不同，dispatch source为应用提供连续的事件源。
 *  除非你显式地取消，dispatch source会一直保留与dispatch queue的关联。
 *  只要相应的事件发生，就会提交关联的代码到dispatch queue去执行。
 *
 *  为了防止事件积压到dispatch queue，dispatch source实现了事件合并机制。
 *  如果新事件在上一个事件处理器出列并执行之前到达，dispatch source会将新旧事件的数据合并。
 *  根据事件类型的不同，合并操作可能会替换旧事件，或者更新旧事件的信息。
 *
 */




#import <Foundation/Foundation.h>

@class ESSTimer;

typedef void(^ESSTimerBlock)(ESSTimer *timer);

/**
 *=-----------------------------------------------------------------------------------------------=
 * ESSTimer
 *=-----------------------------------------------------------------------------------------------=
 * A Timer class, much like NSTimer, but implemented using dispatch queues and sources.
 */
@interface ESSTimer : NSObject

@property(nonatomic, copy, readonly) ESSTimerBlock block;
@property(nonatomic, strong, readonly) dispatch_queue_t queue;
@property(nonatomic, assign, readonly) NSTimeInterval delay;

- (ESSTimer *)initWithDelay:(NSTimeInterval)delay
                    onQueue:(dispatch_queue_t)queue
                      block:(ESSTimerBlock)block;

+ (ESSTimer *)timerWithDelay:(NSTimeInterval)delay
                     onQueue:(dispatch_queue_t)queue
                       block:(ESSTimerBlock)block;

+ (ESSTimer *)scheduledTimerWithDelay:(NSTimeInterval)delay
                              onQueue:(dispatch_queue_t)queue
                                block:(ESSTimerBlock)block;

/**
 * Schedule this timer so that it will fire after the specified delay.
 */
- (void)schedule;

/**
 * Reschedule the timer, so it will fire after the specified delay from the current time, rather
 * than from when it was initially scheduled or last rescheduled.
 * This should not be called before |schedule|, though it will have no effect.
 */
- (void)reschedule;

/**
 * Suspend this timer, so that it will not fire unless and until it has been resumed.
 */
- (void)suspend;

/**
 * Resume the timer to allow it to fire.
 */
- (void)resume;

/**
 * Cancel the timer, preventing it from ever firing again.
 */
- (void)cancel;

@end
