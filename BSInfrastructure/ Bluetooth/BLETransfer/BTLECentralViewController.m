#import "BTLECentralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

#import "TransferService.h"
//在中心这边，你的类必须要继承这两个协议：CBCentralManagerDelegate和CBPeripheralDelegate
//而在周边，需要实现协议为CBPeripheralManagerDelegate
@interface BTLECentralViewController () <CBCentralManagerDelegate, CBPeripheralDelegate ,UITextViewDelegate>{
    //NSMutableString *nsmstring;
}

@property (strong, nonatomic) IBOutlet UITextView   *textview;

/*
 *中心设备
 */
@property (strong, nonatomic) CBCentralManager      *centralManager;
//发现得周边
@property (strong, nonatomic) CBPeripheral          *discoveredPeripheral;

@property (strong, nonatomic) NSMutableData         *data;

@end

@implementation BTLECentralViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    [super viewDidLoad];
    
    // Start up the CBCentralManager
    /** 1.启动中心设备
     *      和创建周边时一样，第一个参数代表CBCentralManager代理，
     *   在这个例子中就是这个view controller；
     *   第二个参数设置为nil，因为Peripheral Manager将Run在主线程中。
     *   如果你想用不同的线程做更加复杂的事情，你需要创建一个队列（queue）并将它放在这儿。
     *
     *  如果想要跟BLE週邊連接，iOS提供了CoreBluetooth framework來與週邊連接，整個程式中分為Discover、Connect、Explore、Interact，下面將會以從連線至BLE讀取到資料為原則來介紹。
     *
     *      要使用CoreBluetooth就要先了解一下CBCentralManager，這個Object掌控整個BLE的管理，
     *  一開始要先對CBCentralManager來做個初始化
     */
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    // And somewhere to store the incoming data
    _data = [[NSMutableData alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    //扫描周边设备
    [self  scan];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 停止扫描
    [self.centralManager stopScan];
    BSLog(@"Scanning stopped");
    
    [super viewWillDisappear:animated];
}

#pragma mark - Central Methods
/** 2.当Central Manager被初始化，我们要检查它的状态，以检查运行这个App的设备是不是支持BLE。
 *  centralManagerDidUpdateState is a required protocol method.
 *  Usually, you'd check for other states to make sure the current device supports LE, is powered on, etc.
 *  In this instance, we're just using it to wait for CBCentralManagerStatePoweredOn, which indicates
 *  the Central is ready to be used.
 *  
 *依照centralManagerDidUpdateState來結果來判斷iDevice是否支援BLE，畢竟BLE是在iphone 4s、New iPad之後才有的，可以根據此項來決定APP
 *  实现以下的代理方法：
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        return;
    }
    [self scan];
    
}


/** Scan for peripherals - specifically for our service's 128bit CBUUID
 *  -scanForPeripheralsWithServices:options: 方法是用于告诉Central Manager，
 *  要开始寻找一个指定的服务了。如果你将第一个参数设置为nil，Central Manager就会开始寻找所有的服务。
 *  kServiceUUID 和创建周边的那个工程中用的是一样的UUID。
 */
- (void)scan
{
    
    [self.centralManager scanForPeripheralsWithServices:
        @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
          options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }
     ];
    BSLog(@"Scanning started");
}


/** 3.一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：
 *This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
 *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is, 
 *  we start the connection process
 *
 *      这个调用通知Central Manager代理（在这个例子中就是view controller），一个附带着广播数据和信号质量
 *  (RSSI-Received Signal Strength Indicator)的周边被发现。这是一个很酷的参数，知道了信号质量，你可以用它去判断远近。
 *  任何广播、扫描的响应数据保存在advertisementData 中，可以通过CBAdvertisementData 来访问它。
 *
 *  现在，你可以停止扫描，而去连接周边了
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{

    BSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    //现在，你可以停止扫描，而去连接周边了：
    //[self.manager stopScan];
    // Ok, it's in range - have we already seen it?
    if (self.discoveredPeripheral != peripheral) {
        // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
        self.discoveredPeripheral = peripheral;
        // And connect
        BSLog(@"Connecting to peripheral %@", peripheral);
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}


/** If the connection fails for whatever reason, we need to deal with it.
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    BSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    [self cleanup];
}


/** We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
 *  基于连接的结果，代理（这个例子中是view controller）会接收centralManager:didFailToConnectPeripheral:error:或者centralManager:didConnectPeripheral:。
 *  如果成功了，你可以访问广播服务的那个周边。因此，在didConnectPeripheral 回调中，你可以写以下代码：
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    BSLog(@"Peripheral Connected");
    
    // Stop scanning
    [self.centralManager stopScan];
    BSLog(@"Scanning stopped");
    
    // Clear the data that we may already have
    [self.data setLength:0];

    // Make sure we get the discovery callbacks
    //在這裡有個重點，當連線成功後引發Delegate時，
    //就必需要針對其CBPeripheral來馬上進行discoverServices的動作，去了解週邊提供什麼樣的Services
    peripheral.delegate = self;
    
    // Search only for services that match our UUID
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}


/** The Transfer Service was discovered
 *  周边开始用一个回调通知它的代理。在上一个方法中，请求周边去寻找服务，周边代理接收-peripheral:didDiscoverServices:。
 *  如果没有Error，可以请求周边去寻找它的服务所列出的特征，
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        //中心同周边握手之后的方法，
        BSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    // Discover the characteristic we want...
    // Loop through the newly filled peripheral.services array, just in case there's more than one.
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:
            @[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]
            forService:service];
    }
}


/** The Transfer characteristic was discovered.
 *  Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
 *  
 *      现在，如果一个特征被发现，周边代理会接收-peripheral:didDiscoverCharacteristicsForService:error:。
 *  现在，一旦特征的值被更新，用-setNotifyValue:forCharacteristic:，周边被请求通知它的代理。
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // Deal with errors (if any)
    if (error) {
        BSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    // Again, we loop through the array, just in case.
    for (CBCharacteristic *characteristic in service.characteristics) {
        // And check if it's the right one
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
           // If it is, subscribe to it
            // 一旦特征的值被更新，用下面方法周边被请求通知它的代理。
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    
    // Once this is complete, we just need to wait for the data to come in.
}

/** The peripheral letting us know whether our subscribe/unsubscribe happened or not
 *
 *  如果一个特征的值被更新，然后周边代理接收-peripheral:didUpdateNotificationStateForCharacteristic:error:。
 *  你可以用-readValueForCharacteristic:读取新的值：
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        BSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exit if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    // Notification has started
    //如果一个特征的值被更新，然后周边代理接收-peripheral:didUpdateNotificationStateForCharacteristic:error:。
    if (characteristic.isNotifying) {//
        BSLog(@"Notification began on %@", characteristic);
        //用-readValueForCharacteristic:读取新的值
        [peripheral readValueForCharacteristic:characteristic];
    }
    // Notification has stopped
    else {
        // so disconnect from the peripheral
        BSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

/** This callback lets us know more data has arrived via notification on the characteristic
 *
 *  当周边发送新的值，周边代理接收-peripheral:didUpdateValueForCharacteristic:error:。
 *  这个方法的第二个参数包含特征。你可以用value属性读取他的值。这是一个包含特征的值的NSData。
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        BSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    
    NSString *stringFromData = [[NSString alloc]
                                initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    // Have we got everything we need?
    if ([stringFromData isEqualToString:@"EOM"]) {
        
        // We have, so show the data, 
        [self.textview setText:[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]];
        
        // Cancel our subscription to the characteristic
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        
        // and disconnect from the peripehral
        [self.centralManager cancelPeripheralConnection:peripheral];
    }

    // Otherwise, just add the data on to what we already have
    [self.data appendData:characteristic.value];
    
    // Log it
    BSLog(@"Received: %@", stringFromData);
}




/** Once the disconnection happens, we need to clean up our local copy of the peripheral
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    BSLog(@"Peripheral Disconnected");
    self.discoveredPeripheral = nil;
    
    // We're disconnected, so start scanning again
    [self scan];
}


/** Call this when things either go wrong, or you're done with the connection.
 *  This cancels any subscriptions if there are any, or straight disconnects if not.
 *  (didUpdateNotificationStateForCharacteristic will cancel the connection if a subscription is involved)
 */
- (void)cleanup
{
    // Don't do anything if we're not connected
    if (!self.discoveredPeripheral.isConnected) {
        return;
    }
    
    // See if we are subscribed to a characteristic on the peripheral
    if (self.discoveredPeripheral.services != nil) {
        for (CBService *service in self.discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        if (characteristic.isNotifying) {
                            // It is notifying, so unsubscribe
                            [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            
                            // And we're done.
                            return;
                        }
                    }
                }
            }
        }
    }
    
    // If we've got this far, we're connected, but we're not subscribed, so we just disconnect
    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
}

/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}


/** Finishes the editing */
- (void)dismissKeyboard
{
    [self.textview resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
