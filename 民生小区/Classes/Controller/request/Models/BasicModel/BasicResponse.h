//
//  BasicResponse.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicHeader.h"

@interface BasicResponse : NSObject
/**responseHeader  返回码信息*/
@property (strong,nonatomic) BasicHeader *responseHeader;
///**responseBody*/
//@property (strong,nonatomic) id responseBody;
@end
