#import "BSNetworkNotify.h"
#import "Reachability.h"
#import "PromptInfo.h"
#import "Conf.h"
#import <AFNetworking/AFNetworking.h>
@interface BSNetworkNotify (){
    NSString* statusString ;
    NSString* statusApp ;
    NSString* netType;
    NSTimer  * timer  ;
    //AFHTTPSessionManager *_sessionManager;
    AFNetworkReachabilityManager *reachabilityManager ;
}

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;
@property (nonatomic) BOOL hidden;

//
@property  ( assign )  NSTimer  * repeatingTimer ;
@end

@implementation BSNetworkNotify

- (id) init{
    self = [super init];
    if (self){
        //statusString=@"";
        //[self netwokrReachabilityInit];
        reachabilityManager =[AFNetworkReachabilityManager sharedManager];
        netType=@"noNet";
    }
    return self;
}

+ (BSNetworkNotify *)sharedBSNetworkNotify {
    static BSNetworkNotify *_singleton;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _singleton = [[super alloc] init];
    });
    
    return _singleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

-( NSString * ) currentNetworkReachability{
    if ([statusApp isEqualToString:@"AppNetOK"]) {
        return statusApp;
    }else{
        statusApp=@"未能连接到服务器";
        
    }
    return statusApp;
}

-(NSString *) currentNetworkType{
    return netType;
}
-(void) networkTimeOut{
    statusApp=@"未能连接到服务器";
}


-(void)  networkRunning{
    statusApp=@"AppNetOK";
}
- ( void ) startNetworkReachability {
    
    if (!timer) {//isNetworkEnabledWithAFNetwork
        timer  =  [ NSTimer  scheduledTimerWithTimeInterval: 15
                  target: self  selector: @selector (timerFireNetChecked)
                   userInfo:nil
                   repeats:YES ];
    }
    // [self startMonitoring];
    
}

-  ( void ) stopNetworkReachability  {
    
    [timer  invalidate ];
    timer  =  nil ;
     //[self stopMonitoring];
    [ reachabilityManager stopMonitoring];
}


-(void)timerFireNetChecked{
    //[self isNetworkEnabled];
    [self isNetworkEnabledWithAFNetwork];
    
}

//使用AFNetwork判断
-(void) isNetworkEnabledWithAFNetwork{
    __block  BOOL bEnabled = FALSE;
    __block NSString *local= statusApp;
    __block NSString *promptInfo;
    [reachabilityManager startMonitoring];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([local isEqualToString: @"未能连接到服务器"]) {
            //
            //[PromptInfo showWithText:@"服务连接超时或系统可能在维护中" topOffset:54 duration:2];
            //return;
            promptInfo=@"服务连接超时或系统可能在维护中";
        }
         switch (status) {
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                        //BSLog(@"目前网络状态WWAN");
                 if (promptInfo) {
                      promptInfo=[NSString stringWithFormat:@"%@\n%@",@"目前网络为3G/2G/4G",promptInfo];
                 }else{
                      //promptInfo=[NSString stringWithFormat:@"%@",@"目前网络为3G/2G/4G"];
                 }
                 [PromptInfo showWithText:promptInfo topOffset:54 duration:2];
                        statusString=@"AppNetOK";
                        netType=@"WWAN";
                        bEnabled=TRUE;
                        break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                        statusString=@"AppNetOK";
                        netType=@"WiFi";
                        bEnabled=TRUE;
                         //[PromptInfo showWithText:@"目前网络为WiFi" topOffset:54 duration:2];
                        if (promptInfo) {
                                promptInfo=[NSString stringWithFormat:@"%@\n%@",@"目前网络环境为WiFi",promptInfo];
                            [PromptInfo showWithText:promptInfo topOffset:54 duration:2];
                            
                        }else{
                            //promptInfo=[NSString stringWithFormat:@"%@",@"WiFi"];
                        }
                        break;
                    case AFNetworkReachabilityStatusNotReachable:
                        statusString=@"noNet";
                        netType=@"noNet";
                        [PromptInfo showWithText:@"无网络环境,请检查手机网络设置情况"
                                       topOffset:54 duration:2];
                        
                        break;
                    default:
                        break;
                }
        
    }];
    [reachabilityManager stopMonitoring];
}

- (void)stopMonitoring{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
}
- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
