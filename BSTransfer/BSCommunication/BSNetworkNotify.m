#import "BSNetworkNotify.h"
#import "Reachability.h"
#import "PromptInfo.h"
#import "Conf.h"
#import <AFNetworking/AFNetworking.h>
@interface BSNetworkNotify (){
    NSString* statusString ;
    NSTimer  * timer  ;
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
        //[self netwokrReachabilityInit];
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

-  ( NSString * ) currentNetworkReachability{
    return statusString;
}
- ( void ) startNetworkReachability {
    if (!timer) {
        timer  =  [ NSTimer  scheduledTimerWithTimeInterval: 5
                                                     target: self  selector: @selector (timerFireNetChecked)
                                                   userInfo:nil
                                                    repeats:YES ];
    }
    //[self startMonitoring];
    
}

-  ( void ) stopNetworkReachability  {
    
    [timer  invalidate ];
    timer  =  nil ;
    
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //[self stopMonitoring];
}


-(void)timerFireNetChecked{
    [self isNetworkEnabled];
    //BOOL netrblty=[self isNetworkEnabledWithAFNetwork];
    //if (!netrblty) {
     //   [PromptInfo showWithText:@"应用不可用" topOffset:54 duration:2];
    //}
    
}

//使用AFNetwork判断
-(BOOL) isNetworkEnabledWithAFNetwork{
    __block  BOOL bEnabled = FALSE;
    AFHTTPSessionManager *_sessionManager= [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KBS_URL]];
    [_sessionManager.reachabilityManager
             setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                 switch (status) {
                     case AFNetworkReachabilityStatusReachableViaWWAN:
                         BSLog(@"目前网络状态WWAN");
                         [PromptInfo showWithText:@"蜂窝网覆盖的连接3G" topOffset:54 duration:2];
                         statusString=@"WWAN";
                          bEnabled=TRUE;
                          break;
                     case AFNetworkReachabilityStatusReachableViaWiFi:
                         BSLog(@"目前网络为WiFi");
                         statusString=@"WiFi";
                          bEnabled=TRUE;
                         
                          [PromptInfo showWithText:@"目前网络为WiFi" topOffset:54 duration:2];
                          
                         break;
                     case AFNetworkReachabilityStatusNotReachable:
                         BSLog(@"目前没有应用启动");
                         statusString=@"NoNet";
                          [PromptInfo showWithText:@"能够连接网络，但是不能同服务建立连接"
                                         topOffset:54 duration:2];

                         break;
                     default:
                         break;
                 }
             }];
    [_sessionManager.reachabilityManager startMonitoring];
    return bEnabled;
}

//-判断当前网络是否可用
-(void) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url =KBS_URL;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //kSCNetworkReachabilityFlagsReachable：能够连接网络
        //kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        
        
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        
        //BOOL netRequired = flags & kSCNetworkReachabilityFlagsConnectionRequired;

        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
        if (flagsReachable) {
            [PromptInfo showWithText:@"不能够连接到应用" topOffset:54 duration:2];
            BSLog(@"不能够连接到应用");
            statusString=@"NoNet";
        }
        
        if (nonWiFi==YES){
            BSLog(@"目前网络为WiFi");
            [PromptInfo showWithText:@"目前网络为WiFi" topOffset:54 duration:2];
            statusString=@"WiFi";
        }
        if (!flagsReachable && nonWiFi) {
            BSLog(@"无WiFi/网络");
            [PromptInfo showWithText:@"无WiFi" topOffset:54 duration:2];
        }
        if (!bEnabled) {
            BSLog(@"无网络环境");
            statusString=@"NoNet";
            [PromptInfo showWithText:@"无网络环境" topOffset:54 duration:2];
        }
        
    }
}

- (void)startMonitoring
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //Change the host name here to change the server you want to monitor.
    self.remoteHostName = KBS_URL;
    self.hostReachability = [Reachability
                             reachabilityWithHostName:self.remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
    
}


/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        [self
         reachability:reachability];
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        self.hidden = (netStatus != ReachableViaWWAN);
        NSString* baseLabelText = @"";
        
        if (connectionRequired)
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", @"Reachability text if a connection is required");
        }
        else
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is active.\nInternet traffic will be routed through it.", @"Reachability text if a connection is not required");
        }
        //self.summaryLabel.text = baseLabelText;
    }
    
    if (reachability == self.internetReachability)
    {
        [self reachability:reachability];
    }
    
    if (reachability == self.wifiReachability)
    {
        [self reachability:reachability];
    }
}


- (void) reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    
    switch (netStatus)
    {
        case NotReachable: {
            BSLog(@"目前没有网络环境");
            statusString=@"NoNet";
            [PromptInfo showWithText:@"目前没有网络环境" topOffset:54 duration:2];
            break;
        }
        case ReachableViaWWAN:{
            statusString=@"WWAN";
            BSLog(@"目前网络状态WWAN");
            [PromptInfo showWithText:@"蜂窝网覆盖的连接3G" topOffset:54 duration:2];
            break;
        }
        case ReachableViaWiFi:{
            statusString=@"WiFi";
            [PromptInfo showWithText:@"目前网络为WiFi" topOffset:54 duration:2];
            
            break;
        }
    }
    if (connectionRequired)
    {
        
        statusString= @"需要连接应用";
    }
}


- (void)stopMonitoring{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
