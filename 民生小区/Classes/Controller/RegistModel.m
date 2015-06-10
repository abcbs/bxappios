//
//  RegistModel.m
//  民生小区
//
//  Created by 闫青青 on 15/4/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "RegistModel.h"
#import "AFNHelp.h"
#import "RegisterViewController.h"
#import "orderDetailOneModel.h"
#import "orderDetailModel.h"
@implementation RegistModel
@synthesize orderArray = _orderArray;
@synthesize orderDetailArray = _orderDetailArray;
@synthesize detailDic = _detailDic;
@synthesize goodDic = _goodDic;
@synthesize goodDic2 = _goodDic2;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}
+ (id)registWithDic:(NSDictionary *)dic{
    RegistModel *registModel = [[RegistModel alloc]initWithDic:dic];
    return registModel;
}
//注册完成按钮调用的方法
- (void)registSuccess{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:self.realName,@"name",self.address,@"address",self.phoneNum,@"phone",nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:self.j,@"sex",nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:self.userName,@"username",self.passWord,@"password",self.commitCode,@"confirmPassword",nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dic1,@"userBase",dic2,@"userDetailed",dic3,@"loginUser", nil];
    [AFNHelp inputValidateCodeWithBlock:^(NSDictionary *infoDic, NSError *error) {
        NSLog(@"%@",infoDic);
        NSLog(@"%@",dic);
        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSLog(@"result:--%@",result);
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
        self.Message = [result objectForKey:@"message"];
        [userDefaults setObject:self.Message forKey:@"self.Message"];
        NSLog(@"self.Message:%@",self.Message);
        if([self.delegate respondsToSelector:@selector(getMessage:)]){
            [self.delegate getMessage:self.Message];
        }
    } and:dic];
    
}
//上传头像按钮调用的方法
- (void)updateHeadImage{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.session = [userDefaults objectForKey:@"sessionId"];
    self.content = [userDefaults objectForKey:@"image"];
    NSDictionary *upDic = [NSDictionary dictionaryWithObjectsAndKeys:self.content,@"headPortrait",@".png",@"picSuffix",self.session,@"sessionId",nil];
    [AFNHelp upPhotoWithBlock:^(NSDictionary *infoDic, NSError *error) {
        NSLog(@"%@",upDic);
        NSLog(@"%@===",self.session);
        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
        
    } and:upDic];
    
}
//登录按钮调用的方法
- (void)loginSuccess{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userName,@"username",self.passWord,@"password", nil];
    [AFNHelp getValidateCodeWithBlock:^(NSDictionary *info, NSError *error) {
        NSLog(@"登录返回的字典：%@",info);
        NSDictionary *result = [info objectForKey:@"responseHeader"];
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
        self.loginMessage = [result objectForKey:@"message"];
        self.errorCode = [info objectForKey:@"responseHeader"];
        NSLog(@"header：%@",self.errorCode);
        NSLog(@"登录信息：%@",self.loginMessage);
        if([self.delegate1 respondsToSelector:@selector(LoginMessage:)]){
            [self.delegate1 LoginMessage:self.loginMessage];
        }//判断是否请求成功，若成功，则取下sessionID
        if ([[self.errorCode objectForKey:@"errorCode"] isEqualToString:@"0000"]) {
            NSDictionary *responseBody = [info objectForKey:@"responseBody"];
            NSLog(@"responseBody--------:%@",responseBody);
            self.sessionID = [responseBody objectForKey:@"sessionId"];
        }
        NSLog(@"%@=====",self.sessionID);
        //保存sessionID
        [userDefaults setObject:self.sessionID forKey:@"sessionId"];
        
    } and:dic];
}
//调用我的订单方法
-(void)myOrderWithBlock:(FinishBlock)finishBlock failed:(FailedBlock)failedBlock{
    //可能多次调用
    if (_finishBlock!=finishBlock) {
        _finishBlock=nil;
        _finishBlock=finishBlock;
    }
    if (_failedBlock!=failedBlock) {
        _failedBlock=nil;
        _failedBlock=failedBlock;
    }
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"sessionId"];
    NSLog(@"会话id为：%@",sessionId);
    [AFNHelp myOrderWithBlock:^(NSDictionary *infoDic, NSError *error) {
        NSLog(@"我的订单返回的字典：%@",infoDic);
        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
        NSArray *body = [infoDic objectForKey:@"responseBody"];
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObject:@"YES" forKey:@"success"];
        //初始化数组
        _orderArray = [NSMutableArray array];
        //这个是什么东西？
        //        MyOrderModel *order = [[MyOrderModel alloc]init];
        
        //  order.totalNumbers =@"11111111";
        // order.totalCash = @"adawdawdawd";
        // [_orderArray addObject:order];
        [body enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __block MyOrderModel *order = [MyOrderModel myOrderWithDic:obj];
            
//            float a = [obj[@"totalCash"] floatValue];
//            order.totalCash = [a stringValue];
            //order.totalCash = [[obj objectForKey:@"totalCash"] stringValue];
            //order.totalNumbers = obj[@"totalNumbers"];
           
             [_orderArray addObject:order];
            //[_orderArray addObject:order];
            //添加成功了之后返回成功的消息
            
            NSLog(@"请求数组：%@",_orderArray);
            
        }];
//        [dataDic setObject:_orderArray forKey:@"object"];
        NSLog(@"请求体:%@",body);
        _finishBlock(_orderArray);
        //请求出错的返回，自己定义
        if (![error isEqual:@"0000"]) {
            _failedBlock(error);
        }
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
        
        
    } and:nil];
    //    MyOrderModel *order = [[MyOrderModel alloc]init];
    //   _orderArray = [NSMutableArray array];
    //    order.orderNumber =@"11111111";
    //    order.totalCash = @"adawdawdawd";
    //    [_orderArray addObject:order];
    
    finishBlock(_orderArray);
    
}

//获取验证码
-(void)validateCode{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneNum,@"phone", nil];
    [AFNHelp validateCodeWithBlock:^(NSDictionary *infoDic, NSError *error) {
      NSLog(@"%@",infoDic);
        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
        self.ValidateMessage = [result objectForKey:@"message"];
        NSLog(@"验证码信息:%@",self.ValidateMessage);
        if([self.delegate2 respondsToSelector:@selector(ValidateCodeMessage:)]){
            [self.delegate2 ValidateCodeMessage:self.ValidateMessage];
        }
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSLog(@"result:--%@",result);
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
    } and:dic];
}
//订单详情  调通
//- (void)orderDetail{
//    [AFNHelp orderDetailWithBlock:^(NSDictionary *infoDic, NSError *error) {
//        NSLog(@"订单详情返回的数据:%@",infoDic);
//        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
//        //保存errorCode
//        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:result forKey:@"responseHeader"];
//        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
//    } and:nil];
//    
//}
//我的订单详情 block 方法
- (void)myOrderDetailWithBlock:(FinishOrderDetailBlock)finishBlock1 failed:(FailedOrderDetailBlock)failedBlock1{
    //可能多次调用
    if (_finishBlock1!=finishBlock1) {
        _finishBlock1=nil;
        _finishBlock1=finishBlock1;
    }
    if (_failedBlock1!=failedBlock1) {
        _failedBlock1=nil;
        _failedBlock1=failedBlock1;
    }
    
    [AFNHelp orderDetailWithBlock:^(NSDictionary *infoDic, NSError *error) {
        NSLog(@"订单详情返回的数据:%@",infoDic);
        NSDictionary *result = [infoDic objectForKey:@"responseHeader"];
        //保存errorCode
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result forKey:@"responseHeader"];
        NSArray *body = [infoDic objectForKey:@"responseBody"];
        //初始化数组
        _orderDetailArray = [NSMutableArray array];
        //初始化字典
        _detailDic = [[NSDictionary alloc]init];
        [body enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __block orderDetailOneModel *orderDetailOne = [orderDetailOneModel myOrderDetailWithDic:obj];
            //商家详情
            _detailDic = [obj valueForKeyPath:@"businessBase"];
            orderDetailOne.businessName = _detailDic[@"name"];
            //商品详情
            NSArray *goodDetail = [obj valueForKeyPath:@"orderDetailBusinessDomain"];
            [goodDetail enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __block orderDetailModel *goodModel = [orderDetailModel myOrderDetailTwoWithDic:obj];
                _goodDic = [[NSDictionary alloc]init];
                _goodDic = [obj valueForKeyPath:@"businessProduct"];
                goodModel.goodIntroduce = _goodDic[@"introduce"];
                //关于商品数量，总价的字典
                _goodDic2 = [[NSDictionary alloc]init];
                _goodDic2 = [obj valueForKeyPath:@"customerOrderDetailed"];
                goodModel.salesPrice = _goodDic2[@"salePrice"];
                goodModel.numbers = _goodDic2[@"numbers"];
                goodModel.total = _goodDic2[@"total"];
            }];
            [_orderDetailArray addObject:orderDetailOne];
            NSLog(@"订单详情请求的数据:%@",_orderDetailArray);
        }];
        _finishBlock1(_orderDetailArray);
        if(![error isEqual:@"0000"]){
            _failedBlock1(error);
        }
        
        NSLog(@"result %@   errorcode %@,   message %@",result,[result objectForKey:@"errorCode"],[result objectForKey:@"message"]);
    } and:nil];
    finishBlock1(_orderDetailArray);

}

@end
