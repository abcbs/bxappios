//
//  LoginMessage.h
//  民生小区
//
//  Created by 闫青青 on 15/5/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>


@protocol LoginMessage <NSObject>

@required
// 代理必须实现的方法，将本控制器的文本域的内容发送给自己的代理
- (void)LoginMessage:(NSString *)message;

@end


