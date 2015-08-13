//
//  BSDesSecurity.m
//  KTAPP
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSDesSecurity.h"
#import "BSDesCrypto.h"
#define keyDes @"KingTeller20150808"

@implementation BSDesSecurity

//static BSDesCrypto

static BSDesSecurity *instance;

-(id) init {
    self = [super init];
    if (self) {
        self.des = [[BSDesCrypto alloc] init];
        //default padding bettween java and ios
       
    }
    return self;
}

#pragma mark -单例与实例化
+(BSDesSecurity *)sharedBSSecurity{
    if (!instance) {
        instance=[[super alloc] init];
    }
    return instance;
}



- (NSString *)encryptString:(NSString *)plainText{
    return [self.des encrypt:plainText key:keyDes];

}

- (NSString *)decryptString:(NSString *)encryptText{
    if (![encryptText isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *trimedStr = [[encryptText mutableCopy] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [self.des decrypt:trimedStr key:keyDes];
}

@end
