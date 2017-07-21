//
//  RegistModel.h
//  民生小区
//
//  Created by 闫青青 on 15/4/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendMessage.h"
#import "LoginMessage.h"
#import "MyOrderModel.h"
#import "ValidateMessage.h"
//我的订单 block
typedef void(^FinishBlock)(id obj);
typedef void(^FailedBlock)(id error);
//我的订单详情 block
typedef void(^FinishOrderDetailBlock)(id obj);
typedef void(^FailedOrderDetailBlock)(id error);
@interface RegistModel : NSObject
//用户名
@property (nonatomic, copy)NSString *userName;
//真实姓名
@property (nonatomic, copy)NSString *realName;
//性别
@property (nonatomic, assign)NSString * sex;
//手机号
@property (nonatomic, assign)NSString * phoneNum;
//验证码
@property (nonatomic, copy)NSString *yanZhengCode;
//密码
@property (nonatomic ,copy)NSString *passWord;
//确认密码
@property (nonatomic ,copy)NSString* commitCode;
//详细地址
@property (nonatomic, copy)NSString *address;
//接收性别的变量
@property (nonatomic, copy)NSString * j;
//设置sessionID
@property (strong, nonatomic) NSString *sessionID;
//取sessionID
@property (strong, nonatomic) NSString *session;
//取图片的base-64
@property (strong, nonatomic) NSString *content;
//注册的message
@property (strong, nonatomic) NSString *Message;
//登录的message
@property (strong ,nonatomic) NSString *loginMessage;
//errorcode
@property (strong, nonatomic) NSDictionary *errorCode;
//存储“我的订单”请求下来的数据
@property (nonatomic, copy) NSMutableArray *orderArray;
//存储“我的订单详情”请求下来的数据
@property (nonatomic, copy) NSMutableArray *orderDetailArray;
//获取验证码message
@property (strong, nonatomic) NSString *ValidateMessage;
//订单详情 关于商家的字典
@property (strong, nonatomic) NSDictionary *detailDic;
//订单详情 关于商品的字典
@property (strong, nonatomic) NSDictionary *goodDic;
//订单详情 关于商品数量，总价的字典
@property (strong, nonatomic) NSDictionary *goodDic2;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (id)registWithDic:(NSDictionary *)dic;
//注册完成按钮调用的方法
- (void)registSuccess;
//上传头像按钮调用的方法
- (void)updateHeadImage;
//登录按钮调用的方法
- (void)loginSuccess;
//获取验证码
-(void)validateCode;
//订单详情  调通
//- (void)orderDetail;
//实现协议
@property (nonatomic, readwrite) id<SendMessage> delegate;
@property (nonatomic, readwrite) id<LoginMessage> delegate1;
@property (nonatomic, readwrite) id<ValidateMessage>delegate2;
//我的订单的block
@property(nonatomic,copy)FinishBlock finishBlock;
@property(nonatomic,copy)FailedBlock failedBlock;
//我的订单详情的block
@property(nonatomic,copy)FinishOrderDetailBlock finishBlock1;
@property(nonatomic,copy)FailedOrderDetailBlock failedBlock1;
//我的订单的block 声明的方法
-(void)myOrderWithBlock:(FinishBlock)finishBlock failed:(FailedBlock)failedBlock;
//我的订单详情的block 声明的方法
- (void)myOrderDetailWithBlock:(FinishOrderDetailBlock)finishBlock1 failed:(FailedOrderDetailBlock)failedBlock1;
@end
