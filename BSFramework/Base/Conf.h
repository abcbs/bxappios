//
//  Conf.h
//  民生小区
//
//  Created by LouJQ on 15-5-1.
//  Copyright (c) 2015年 KT. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ErrorMessage.h"

@interface Conf : NSObject

#ifdef DEBUG
#define BSLog(...) NSLog(__VA_ARGS__)
#else
#define BSLog(...)
#endif

// objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)

#define BSDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
/**
 *基础URL
 */
#define KBS_URL @"http://192.168.1.102:8090/"

#pragma mark--iOS显示适配

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
/**
 *  导航栏高度
 */
#define NAVIGATIONBAR_HEIGHT 66

/**
 *  导航宽度
 */
#define NAVIGATIONBAR_WIDTH (SCREEN_WIDTH)

/**
 * 导航栏X坐标
 */
#define NAVIGATIONBAR_X 0


/**
 * 导航栏X坐标
 */
#define NAVIGATIONBAR_Y 0

/**
 *  状态栏高度
 */
#define STATUS_HEIGHT 22

/**
 *内容高度应当是屏幕高度减去状态栏和导航栏高度
 */
#define CONTENT_HIGH (SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)


/**
 *  状态栏加上导航栏的高度
 */
#define NAVIGATION_ADD_STATUS_HEIGHT (NAVIGATIONBAR_HEIGHT+STATUS_HEIGHT)

/**
 * 适配度
 */
#define scale (CGFloat) [[UIScreen mainScreen] scale]


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)

#define IS_IPHONE_6 (IS_IPHONE && ([[UIScreen mainScreen] nativeScale] == 2.0f)&&([[UIScreen mainScreen] bounds].size.height-667)==0)


+(NSString*)deviceMachine;
/**
 *获取IOS版本
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue];

#pragma mark --获取宽度和高度，及其适配方法
extern float autoSizeScaleX;
extern float autoSizeScaleY;

+(void)autoSizeScale;

#define autoStyleSize [Conf autoSizeScale]
//UIAlertView
#define KT_AlertView_(a) [[[UIAlertView alloc]initWithTitle:@"提示" message:a delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]



#pragma mark--对URL统一管理
//上传头像
#define UpHeadImage_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/uploadportrait"];
//我的订单
#define MyOrder_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"order/userorderbases"];
//订单详情  先弄一个固定的id:1
#define OrderDetail_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"order/orderdetaileds/1"];
//验证码接口
#define Validate_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/generatecode"];

/**
 *注册
 */
#define USER_REGISTER_SCHEMA @"user/register"

/**
 *登陆
 */
#define USER_LOGIN_SCHEMA @"user/login"

#pragma mark--功能的请求参数及请求参数模

/**
 *送水列表的列宽度
 */
#define WATER_LIST_ROW_HIGH 110

/**
 *送水分类
 */
#define WATER_CATA @"/1001/"

/**
 *送水列表请求模式
 */
#define WATER_LIST_SCHEMA @"water/waterinformations/1001/:id/:count"

/**
 *送水列表请求
 */
#define WATER_LIST @"water/waterinformations/1001/"

/**
 *送水详情评论信息请求模式
 */
#define WATER_DETAIL_COMMENT_SCHEMA @"productcomment/productcomments/:productid/:maxId/:dataCount"

/**
 *送水详情评论请求
 */
#define WATER_DETAIL_COMMENT @"productcomment/productcomments/"

/**
 *购物车某客户选中商品时数量增加
 */
#define WATER_SHOPPCART_ADDCART_SCHEMA @"shoppingcart/addcart/:sessionId"

/**
 *购物车某客户选中商品时数量增加
 */
#define WATER_SHOPPCART_ADDCART @"shoppingcart/addcart"


/**
 *购物车列表
 */
#define WATER_SHOPPCART_USERCARTS_SCHEMA @"shoppingcart/usercarts/:sessionId"


#define WATER_SHOPPCART_USERCARTS @"shoppingcart/usercarts/"


#define  WATER_SHOPPCART_DELCARTLIST @"shoppingcart/delcartlist"


#define WATER_SHOPPCART_UPDATECART @"shoppingcart/updatecart"


#pragma mark--异常信息管理
#define Success @"0000"  //成功
#define NULL_OR_BLACK @"1000"//查询结果为空或 未查询到相应数据
#define RESOURCE_NOT_EXISTS @"1001" //资源不存在
#define PARAMS_ERROR @"1002" //参数错误
#define LOGIN_FAIL @"1003" //用户名或密码错误导致登录失败
#define REGISTER_FAIL @"1004" //注册失败
#define ADD_CART_FAIL @"1005" //加入购物车失败
#define UPDATE_CART_FAIL @"1006" //更新购物车失败
//系统异常类
#define QUERY_EXCEPTION @"2001" //查询出现异常
#define INSERT_EXCEPTION @"2002" //数据插入异常
#define UPDATE_EXCEPTION @"2003" //数据更新异常


#pragma mark--公共机制显示相关配置信息

#pragma mark--运行时表格运行组件BSUITableViewInitRuntimeController配置
/**
 *标题栏，缺省的图片，目前仅仅使用颜色，没有使用图片
 */
#define NAVIGATION_IMAGE @"ckxq-122"

/**
 *自动跳转功能表格默认的列数
 */
#define BSTABLE_CONTENT_COLUMN_NUMBER 1

/**
 *图片选择的最小数据
 */
#define PICK_IMAGE_MIN 1

#define PICK_IMAGE_MAX 9

#define TAKE_PHOTP_MAX 0

/**
 *日期格式
 */
#define DATEFORMAT_YYYY_MM_DD  @"yyyy-MM-dd"

#define DEFAULT_DATE @"2015-01-01"


/**
 *人员角色
 */
#define DEFAULT_ROLE NO

//一般用户、商户联系人、商户法人、运营人员
#define USER_TYPE_COMMON   @"0"
#define USER_TYPE_CONTACT  @"1"
#define USER_TYPE_ENTITY   @"2"
#define USER_TYPE_OPERATOR @"3"
//anonymity
#define USER_TYPE_ANONY    @"4"
//多少次之后，系统把用户锁定
#define USER_LONGIN_NUMBER 5
//认证（摘要认证）之后，需要系统重新提供登陆
#define AUTHORIZATION_RETRY 2

//摘要认证
#define DIGEST_NONCE_KEY @"testNonce"
#define DIGEST_NONCE_VALIDITY_SEC 10000

#define DATA_IS_LOCAL NO

typedef void (^BSHTTPResponse)(NSObject *response,
                               NSError *error,
                               ErrorMessage *bsErrorMessage);

+(NSDate*) convertDateFromString:(NSString*)uiDate;

+ (NSString *)convertStringFromDate:(NSDate *)date;

+(NSString *)urlWithShoppingCart;



/** jiaru购物车的url */
+(NSString *)urlWithAddShoppingCart;

/** 删除购物车url */
+(NSString *)urlWaterShoppingDelcartlist;

/** 更新购物车url */
+(NSString *)urlWaterShoppingUpdateCart;


//对异常的处理
///+ (BOOL)isNetwork;

extern  NSString *bsNetstatus;

/*
 *网络连接系统正常
 */
#define networkRight 10000000
#define networkError -1001
+(void)handleNetworkError:(NSError *)error;

/**
 *默认返回0，表示目前还没有网络信息返回
 */
+(NSInteger )checkNetWork;


+(NSString *)appInfo;
@end