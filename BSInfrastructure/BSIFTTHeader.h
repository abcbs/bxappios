//
//  BSIFTTHeader.h
//  KTAPP
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#ifndef KTAPP_BSIFTTHeader_h
#define KTAPP_BSIFTTHeader_h

#pragma mark -相册选择图片组件
/**
 选择图片处理组件
 */
#import "BSImagePickerController.h"
#import "BSImagePicker.h"

/*
 *拍照片
 */
#import "BSPhotoTakeController.h"


#import "BSPhotoImagePickerController.h"

/**
 *消息推送相关
 */
#import  "BSTRPushHelper.h"

#pragma mark -BLE处理组件



#import "BSBLEViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>
/**
 *LE描述信息
 */
#import "BLEInfo.h"

#import "BLCentralExtention.h"
/**
 *LE发现设备控制器
 */
#import "BLEDevicesTableViewController.h"

/**
 *LE的详细信息控制器
 */
#import "BLEDeviceDetailsTableViewController.h"


/**
 *LE手工添加
 */
#import "BLEDevicesAddTableViewController.h"
/**
 *LE中心
 */
#import "BTLECentralViewController.h"

/**
 *LE周边
 */
#import "BTLEPeripheralViewController.h"


//百度地图
#import "BSBaiduViewController.h"

#import "WayPointRouteSearchViewController.h"

#import "BSRadarNearbyViewController.h"

#import "BSRadarUploadViewController.h"



#endif
