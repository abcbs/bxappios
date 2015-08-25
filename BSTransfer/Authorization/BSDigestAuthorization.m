//
//  BSDigestAuthorization.m
//  KTAPP
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSDigestAuthorization.h"
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "BSCMFrameworkHeader.h"
/*
 
 分别配置每一个 session 对象。( NSURLConnection 很难做到 ) 分类：
 1) defaultSessionConfiguration: 默认 session 配置，类似 NSURLConnection 的标准配置，使用硬盘来存储缓存数据。
 
 2) backgroundSessionConfiguration: 后台session配置，与默认配置类似，不同的是会在后台开启另一个线程来处理网络数据。
    注意: 这里如果设置了超时限制的话，可能会导致一直下载失败。因为后台下载会根据设备的负载程度决定分配下载的资源。
    后台处理,由系统统一决定,并且所有的需要后台处理的都会被同时列队,或者说同时进行,只要负载允许;
 
 3) ephemeralSessionConfiguration: 临时session配置，与默认配置相比，这个配置不会将缓存、cookie等存在本地，只会存在内存里，所以当程序退出时，所有的数据都会消失
 
 */

@interface BSDigestAuthorization (){
}

@end


@implementation BSDigestAuthorization

static NSURLSessionConfiguration *config;
static BSDigestAuthorization *instance;

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

+(BSDigestAuthorization *) instaceDigestAuthorization{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
        
    }
    return instance;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        static dispatch_once_t oncePredicate;
        
        dispatch_once(&oncePredicate, ^{
            config =  [NSURLSessionConfiguration defaultSessionConfiguration];
        });
    }
    return self;
}

#pragma mark Authorization: Basic xxxxxxxxxx.
-(void)basicAuthorization:(NSString *)user password:(NSString *)password{
    
    NSString *userPasswordString = [NSString stringWithFormat:@"%@:%@", user, password];
    NSData * userPasswordData = [userPasswordString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
    NSString *authString = [NSString stringWithFormat:@"Basic: %@", base64EncodedCredential];
    
    [config setHTTPAdditionalHeaders:@{@"Authorization":authString}];
    
}

/**
 无登陆请求响应
 摘要认证 digest authentication　　　←　HTTP1.1提出的基本认证的替代方法
 服务器端以nonce进行质询，客户端以用户名，密码，nonce，HTTP方法，请求的URI等信息为基础产生的response信息进行认证的方式。
 ※　不包含密码的明文传递
 
 摘要认证步骤：
 1. 客户端访问一个受http摘要认证保护的资源。
 2. 服务器返回401状态以及nonce等信息，要求客户端进行认证。
 
 HTTP/1.1 401 Unauthorized
 WWW-Authenticate: Digest
 realm="testrealm@host.com",
 qop="auth,auth-int",
 nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
 opaque="5ccc069c403ebaf9f0171e9517f40e41"
 
 Digest 
 realm="REST-Realm", 
 qop="auth", 
 nonce="MTQ0MDUyNzI3MTY2MjphY2E0OGJiMmUxNzU1Yjg3ZWQ3MTcyMDgxZGJmOTlmNw=="

 3. 客户端将以用户名，密码，nonce值，HTTP方法, 和被请求的URI为校验值基础而加密（默认为MD5算法）的摘要信息返回给服务器。
 认证必须的五个情报：
 　　　　　・ realm ： 响应中包含信息
 　　　　　・ nonce ： 响应中包含信息
 　　　　　・ username ： 用户名
 　　　　　・ digest-uri ： 请求的URI
 　　　　　・ response ： 以上面四个信息加上密码信息，使用MD5算法得出的字符串。
 
 
 
 特记事项：
 1. 避免将密码作为明文在网络上传递，相对提高了HTTP认证的安全性。
 2. 当用户为某个realm首次设置密码时，服务器保存的是以用户名，realm，密码为基础计算出的哈希值（ha1），而非密码本身。
 3. 如果qop=auth-int，在计算ha2时，除了包括HTTP方法，URI路径外，还包括请求实体主体，从而防止PUT和POST请求表示被人篡改。
 4. 但是因为nonce本身可以被用来进行摘要认证，所以也无法确保认证后传递过来的数据的安全性。
 
 ※　nonce：随机字符串，每次返回401响应的时候都会返回一个不同的nonce。
 ※　nounce：随机字符串，每个请求都得到一个不同的nounce。
 ※　MD5(Message Digest algorithm 5，信息摘要算法)
 ① 用户名:realm:密码　⇒　ha1
 ② HTTP方法:URI　⇒　ha2
 ③ ha1:nonce:nc:cnonce:qop:ha2　⇒　ha3
 */



-(void)digestAuthorization:(NSString *)user digestURI:(NSString *) uri headerAuthenticate:(NSString *)authenticate

{
    /*
    Authorization: Digest
    username="Mufasa",　 ←　客户端已知信息
    realm="testrealm@host.com", 　 ←　服务器端质询响应信息
    nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093", 　←　服务器端质询响应信息
    uri="/dir/index.html", ←　客户端已知信息
    qop=auth, 　 ←　服务器端质询响应信息
     
    nc=00000001, ←　客户端计算出的信息
    cnonce="0a4f113b", ←　客户端计算出的客户端nonce
    response="6629fae49393a05397450978507c4ef1", ←　最终的摘要信息 ha3
    opaque="5ccc069c403ebaf9f0171e9517f40e41"　 ←　服务器端质询响应信息
    */
  
    NSString *authString =
    [NSString stringWithFormat:@"%@ username=%@ digest-uri=%@",
        authenticate,user,uri];
    BSLog(@"组装的摘要字符串为:\t%@",authString);
    [config setHTTPAdditionalHeaders:@{@"Authorization":authString}];
    
}

-(NSURLSessionConfiguration *)currentConfiguration{
    return config;
}
@end
