//
//  SendMessage.h
//
//  Created by snow on 14-12-27.
//  Copyright (c) 2015年 wgw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SendMessage <NSObject>

@required
// 代理必须实现的方法，将本控制器的文本域的内容发送给自己的代理
- (void)getMessage:(NSString *)message;

@end
