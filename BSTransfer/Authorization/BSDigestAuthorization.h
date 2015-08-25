//
//  BSDigestAuthorization.h
//  KTAPP
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSDigestAuthorization : NSObject

+(BSDigestAuthorization *) instaceDigestAuthorization;

-(void)basicAuthorization:(NSString *)user password:(NSString *)password;

-(void)digestAuthorization:(NSString *)user digestURI:(NSString *) uri headerAuthenticate:(NSString *)authenticate;

-(NSURLSessionConfiguration *)currentConfiguration;
@end
