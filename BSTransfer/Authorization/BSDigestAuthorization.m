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
//Session配置信息
static NSURLSessionConfiguration *config;
//单例
static BSDigestAuthorization *instance;

//摘要字符串
static NSString *digestAuthString;
//客户端时间间隔
static long nonceValiditySeconds;
//客户端摘要字符串
static NSString * digestNonceKey;

static NSMutableDictionary *ncUriDict;

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
        //计算nonce的方法
        digestNonceKey=DIGEST_NONCE_KEY;
        nonceValiditySeconds=DIGEST_NONCE_VALIDITY_SEC;
        ncUriDict=[ NSMutableDictionary dictionary];
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



-(void)digestAuthorization:(NSString *)username password:(NSString *)password  digestURI:(NSString *) uri
        httpMethod:(NSString *)httpMethod headerAuthenticate:(NSString *)authenticate

{
    BSLog(@"响应的摘要信息:\t%@",authenticate);
    //
    NSParameterAssert(authenticate);
    
    //Digest realm="REST-Realm", qop="auth", nonce="MTQ0MDYwMzI3OTYzMToyYTNmMmQ4Mzc1NDlmNmRhOGRlOTUyYWY2OGJkYWM3Yg=="

    NSString *realm=nil;
    NSString *qop=nil;
    NSString *nonce=nil;
    @try {
        
        NSArray *array = [authenticate componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        NSParameterAssert(array);
        NSString *realmResponse=array[0];
        realmResponse=[realmResponse substringFromIndex:7];
        realm= [realmResponse componentsSeparatedByString:@"\""][1];
        qop=[array[1] componentsSeparatedByString:@"\""][1];
        nonce=[array[2] componentsSeparatedByString:@"\""][1];

    }
    @catch (NSException *exception) {
        BSLog(@"摘要请求处理异常");
        NSString *n=[[NSString alloc]initWithFormat:
                     @"处理响应摘要完成\nrealm:\t%@\tqop:\t%@\tnonce:\t%@",realm,qop,nonce ];
        BSLog(@"处理响应摘要完成\nrealm:  \t%@   \tqop: \t%@\tnonce:\t%@",realm,qop,nonce);
        NSException *e = [NSException
                          exceptionWithName: @"摘要请求处理异常"
                          reason: n
                          userInfo: nil];
        @throw e;
    }
    BSLog(@"处理响应摘要完成\nrealm:  \t%@   \tqop: \t%@\tnonce:\t%@",realm,qop,nonce);
   
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
    
    /**
     *  ① 用户名:realm:密码　⇒　ha1
     *  ② HTTP方法:URI　⇒　ha2
     *  ③ ha1:nonce:nc:cnonce:qop:ha2　⇒　ha3
    */
    //String a1Md5;
    //String a2 = httpMethod + ":" + uri;
    //String a2Md5 = md5Hex(a2);
    NSString * a1 =[[NSString alloc]initWithFormat:@"%@:%@:%@",username, realm,password];
    NSString * a1Md5=[a1 md5HexDigest];
    
    NSString * a2 =[[NSString alloc]initWithFormat:@"%@:%@",httpMethod, uri];
    NSString * a2Md5=[a2 md5HexDigest];
    NSString * digest=nil;
    NSString * nc=[self ncCurrent:uri];
    NSString *cnonce ;
    if (qop==nil) {
        //digest = a1Md5 + ":" + nonce + ":" + a2Md5;
        digest =[[NSString alloc]initWithFormat:@"%@:%@:%@",a1Md5, nonce,a2Md5];
    }else if ([qop isEqualToString: @"auth"]){
       //digest = a1Md5 + ":" + nonce + ":" + nc + ":" + cnonce + ":" + qop + ":" + a2Md5;
        //计算cnonce
        //根据当前时间与配置值获得的过期事件值
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:datenow];
        long expiryTime = interval + (nonceValiditySeconds * 1000);
        NSString *signatureValue=[[NSString alloc]initWithFormat:@"%ld:%@",expiryTime, DIGEST_NONCE_KEY];
        signatureValue=[signatureValue md5HexDigest];
        cnonce = [[NSString alloc]initWithFormat:@"%ld:%@",expiryTime, signatureValue];
        cnonce=[cnonce base64EncodedString];

        digest =[[NSString alloc]initWithFormat:@"%@:%@:%@:%@:%@:%@",a1Md5, nonce,nc,cnonce,qop,a2Md5];
    }else{
        NSString *n=[[NSString alloc]initWithFormat:
                     @"处理响应摘要完成\nrealm:\t%@\tqop:\t%@\tnonce:\t%@",realm,qop,nonce ];
        NSException *expression = [NSException
                          exceptionWithName: @"摘要请求,不支持qop"
                          reason: n
                          userInfo: nil];

        @throw expression;
    }
    if (digest) {
        digest=[digest md5HexDigest];
    }
    
    digestAuthString =
    [NSString stringWithFormat:@"%@ , username=\"%@\"  , response=\"%@\" , uri=\"%@\" ,nc=\"%@\" , cnonce=\"%@\" ",
        authenticate,username,digest, uri,nc,cnonce];
    BSLog(@"组装的摘要字符串为:\t%@",digestAuthString);
    [config setHTTPAdditionalHeaders:@{@"Authorization":digestAuthString}];
    
}

-(NSString *)currentDigestAuthorization{
    return digestAuthString;
}

-(void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer{
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if (digestAuthString) {
        [requestSerializer setValue:digestAuthString forHTTPHeaderField:@"Authorization"];
    }
}

-(NSURLSessionConfiguration *)currentConfiguration{
    return config;
}

-(void) ncDisgest:(NSString *)uri{
    NSString *ncUri=(NSString *)[ncUriDict objectForKey:uri];
    NSString *currentStr=[[NSString alloc]initWithFormat:@"%d",1 ];
    if (ncUri) {
        int current=[ncUri intValue];
        current++;
        currentStr=[[NSString alloc]initWithFormat:@"%d",current ];
        //[ncUriDict setObject:currentStr forKey:uri];
    }
    [ncUriDict setObject:currentStr forKey:uri];
}

-(NSString *)ncCurrent:(NSString *)uri{
    NSString *ncUri=(NSString *)[ncUriDict objectForKey:uri];
    int current=1;
    if (ncUri) {
        current=[ncUri intValue];
    }
    NSString *nc=[[NSString alloc]initWithFormat:@"%x",current ];
    return nc;
}
@end
