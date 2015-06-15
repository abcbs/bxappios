//
//  Conf.h
//  民生小区
//
//  Created by LouJQ on 15-5-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface Conf : NSObject

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
/**
 *  屏幕宽度;
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
/**
 *  导航栏高度
 */
#define NAVIGATIONBAR_HEIGHT 44

/**
 *  状态栏高度
 */
#define STATUS_HEIGHT 20


#define CONTENT_HIGH (SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)


/**
 *  状态栏加上导航栏的高度
 */
#define NAVIGATION_ADD_STATUS_HEIGHT (NAVIGATIONBAR_HEIGHT+STATUS_HEIGHT)

/**
 * 适配度
 */
#define scale (CGFloat)[[UIScreen mainScreen] scale]


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)

#define IS_IPHONE_6 (IS_IPHONE && ([[UIScreen mainScreen] nativeScale] == 2.0f)&&([[UIScreen mainScreen] bounds].size.height-667)==0)


/**
 *获取IOS版本
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue];



//UIAlertView
#define KT_AlertView_(a) [[[UIAlertView alloc]initWithTitle:@"提示" message:a delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#pragma mark--对URL统一管理
//登录
#define Login_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/login"];
//app_url +@"/user/login";
//注册
#define Regist_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/register"];
//上传头像
#define UpHeadImage_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/uploadportrait"];
//我的订单
#define MyOrder_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"order/userorderbases"];
//订单详情  先弄一个固定的id:1
#define OrderDetail_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"order/orderdetaileds/1"];
//验证码接口
#define Validate_url [[[NSString alloc] initWithString:KBS_URL]stringByAppendingString:@"user/generatecode"];


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

#define WATER_LIST_SCHEMA @"water/waterinformations/1001/:id/:count"

/**
 *送水列表的列宽度
 */
#define WATER_LIST_ROW_HIGH 110;

extern NSString *const KBS_URL;
extern NSString *const WATER_LIST;

extern NSString *const WATER_CATA;



extern NSString *const WATER_DETAIL_COMMENT;

extern NSString *const WATER_SHOPPCART_ADDCART;


extern NSString *const WATER_SHOPPCART_USERCARTS;

extern NSString *const WATER_SHOPPCART_DELCARTLIST;

extern NSString *const WATER_SHOPPCART_UPDATECART;

/**
 
 */
+(NSString *)urlBase;

+(NSString *)urlWaterList;
+(NSString *)urlWaterDetailComment;
/** 加入购物车的url */
//+(NSString *)urlWithAddCart;
/** 查看购物车的url */
+(NSString *)urlWithShoppingCart;


/** jiaru购物车的url */
+(NSString *)urlWithAddShoppingCart;
/** 删除购物车url */
+(NSString *)urlWaterShoppingDelcartlist;

/** 更新购物车url */
+(NSString *)urlWaterShoppingUpdateCart;

//对异常的处理
+ (BOOL)isNetwork;

@end