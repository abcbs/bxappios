//
//  BSSecurityConfig.h
//  KTAPP
//
//  Created by admin on 15/9/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BSSecurityField : NSObject
    @property (retain, nonatomic) NSString *fieldName;
    @property (assign, nonatomic) int type;//1-请求加密，2-响应解密，3-请求加密，响应解密
@end

@interface BSSecurityConfig : NSObject

  @property (strong, nonatomic) NSMutableArray *fields;
  @property (strong,nonatomic) Class clzz;

+(instancetype)initWithClass:(Class)clzz;

-(void)addBSSecurityField:(BSSecurityField *) securityField;

-(void)addBSSecurityField:(NSString *) securityField crptyType:(int)crptyType;
@end
