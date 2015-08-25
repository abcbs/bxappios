//
//  BSHTTPNetworking.m
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BSHTTPNetworking.h"
#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"
#import "LoginUser.h"
#import "UserSession.h"
#import "BSDigestAuthorization.h"

@interface BSHTTPNetworking (){
    
}

@property (nonatomic, strong) AFHTTPRequestOperationManager *bsmanager;

@property (nonatomic, strong) BSModelRouter *router;


@end

@implementation BSHTTPNetworking

//@synthesize bsmanager;

@synthesize router;

static LoginUser *loginUser;
static BSDigestAuthorization *digestAuthorization;
static int loginRetryNumber;

+(void)currentUser:(LoginUser *)user{
    loginUser=user;
}
+(instancetype)httpManager
{
    return [[super alloc] initWithBaseURL];
}

- (instancetype)initWithBaseURL{
    self = [super init];
    if (!self) {
        return nil;
    }
    if(!self.router) {
        self.router=  [[BSModelRouter alloc]
                       initWithBaseURL:[NSURL URLWithString:KBS_URL]];
        digestAuthorization=[BSDigestAuthorization instaceDigestAuthorization];
    }
    return self;
}

+(instancetype)httpManager:(NSURLSessionConfiguration *)configuration
{
    return [[super alloc] initWithBaseURL:configuration];
}

- (instancetype)initWithBaseURL:(NSURLSessionConfiguration *)configuration{
    self = [super init];
    if (!self) {
        return nil;
    }
    if(!self.router) {
        self.router=  [[BSModelRouter alloc]
                       initWithBaseURL:[NSURL URLWithString:KBS_URL] sessionConfiguration:configuration];
        
    }
    return self;
}

+(void)httpGET:(NSString *)restPath
   pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
       keyPath:(NSString *)keyPath
         block:(BSHTTPResponse)block
{
 
    [self httpGET:restPath
            pathPattern:pathPattern
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:nil
     ];
    
}

+(void)httpGET:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    BSHTTPNetworking * bshttp=[self httpManager];
     [bshttp get:restPath
        pathPattern:pathPattern
        modelClass:modelClass
        keyPath:keyPath
        block:block
        errorUILabel:errorUILabel
      ];
}


-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block{
    
    [self get:restPath pathPattern:pathPattern modelClass:modelClass keyPath:keyPath block:(BSHTTPResponse)block
        errorUILabel:nil
     ];
}

/**
 *
 */
#pragma mark -get
-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    NSLog(@"本次请求URL\t%@",KBS_URL);
    NSLog(@"本次请求路径为%@",restPath);
    NSLog(@"本次请求方法GET");
    
    [BSHTTPNetworking httpManager];
    
    [router routeGET:pathPattern modelClass:[modelClass class] keyPath:keyPath];
    
    [router GET:restPath parameters:nil
        success:[self block:block errorUILabel:errorUILabel]
        failure:[self block:block failure:nil errorUILabel:errorUILabel]
     ];
    
}

+(void)httpPOST:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
     parameters:(id)parameters
     modelClass:(Class)modelClass
     keyPath:(NSString *)keyPath
     block:(BSHTTPResponse)block
{
    [self httpPOST:restPath
       pathPattern:pathPattern
        parameters:parameters
        modelClass:modelClass
        keyPath:keyPath
        block:block
        errorUILabel:nil
     ];
}

+(void)httpPOST:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    BSHTTPNetworking * bshttp=[self httpManager];
    [bshttp  post:restPath pathPattern:pathPattern
            parameters:parameters
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:errorUILabel
     ];
}

-(void)post:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
      block:(BSHTTPResponse)block{
    [self  post:restPath pathPattern:pathPattern
            parameters:parameters
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:nil
     ];
}


#pragma mark - BSHTTP HandlesHttp Restful Post ,Data Model Descrited JMExtension
-(void)post:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    NSLog(@"本次请求URL\t%@",KBS_URL);
    NSLog(@"本次请求路径为\t%@",restPath);
    NSLog(@"本次请求参数\t%@",parameters);
    NSLog(@"本次请求方法POST");
    
    //[BSHTTPNetworking httpManager];
    
    [router routePOST:pathPattern modelClass:[modelClass class] keyPath:keyPath];
    
    [router POST:restPath parameters:parameters
         success:[self block:block errorUILabel:errorUILabel]
         failure:[self block:block failure:nil errorUILabel:errorUILabel]
    ];
   
}



#pragma mark - BSHTTP Handles
- (BSHTTPRequestSuccess)
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel{
    return ^(NSURLSessionDataTask *task, id responseObject, id model) {
        [Conf handleNetworkError:nil];
        if (block&&![model isKindOfClass:[ErrorMessage class]]) {
            block(model,nil,nil);
        }else if(block&& [model isKindOfClass:[ErrorMessage class]]){
            ErrorMessage *bserror=model;
            NSLog(@"本次请求返回信息为%@",
                  bserror.description);
            if (errorUILabel) {
                errorUILabel.text=[(ErrorMessage *)model message ];
            }else{
                NSString *message=[[[NSString alloc] initWithString:
                                    [(ErrorMessage *)model errorCode ]]
                                   stringByAppendingString:
                                   [(ErrorMessage *)model message ]];
                [BSUIComponentView confirmUIAlertView:message];
            }
        }
    };
}

+(void)httpAuthorizationPOST:(NSString *)restPath
                 pathPattern:(NSString * )pathPattern
                  parameters:(id)parameters
                  modelClass:(Class)modelClass
                     keyPath:(NSString *)keyPath
                       block:(BSHTTPResponse)block
{
    
    BSHTTPNetworking * bshttp=[self httpManager:digestAuthorization.currentConfiguration];
    [bshttp  post:restPath pathPattern:pathPattern
       parameters:parameters
       modelClass:modelClass
          keyPath:keyPath
            block:block
     errorUILabel:nil
     ];
}

- (void (^)(NSError *error))
    block:(BSHTTPResponse)block
    failure:(BSHTTPRequestFailure)failure
    errorUILabel:( UILabel *)errorUILabel
{
    return ^(NSError *error) {
        
        NSDictionary *dict=error.userInfo;
        //错误码
        NSString *localizedDescription=[dict objectForKey:@"NSLocalizedDescription"];
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)[dict objectForKey:@"com.alamofire.serialization.response.error.response"];
        
        NSDictionary *headerFields = [httpResponse allHeaderFields];
        //key	__NSCFConstantString *	@"Www-Authenticate"	0x00000001107bc478
        //value	__NSCFString *	@"Digest realm=\"REST-Realm\", qop=\"auth\", nonce=\"MTQ0MDUyNDE4OTUxOTplYjAyY2UyYzhhOGQ1MTU4YjRmMWVhNjQ0NzRiMDZjOQ==\""	0x00007f83a870e290
        NSString *authenticate=(NSString *)[headerFields objectForKey:@"Www-Authenticate"];
   
        NSString *uri=(NSString *)[dict objectForKey:@"NSErrorFailingURLKey"];;
        [digestAuthorization digestAuthorization:@"loginUser.userName"
                              digestURI:uri
                              headerAuthenticate:authenticate];
        BSLog(@"系统出现异常，权限信息:\n%@",authenticate);
        //key	__NSCFConstantString *	@"Date"	0x00000001107bbc98
        NSString *date=(NSString *)[headerFields objectForKey:@"Date"];
        BSLog(@"系统出现异常，时间戳信息:\n%@",date);

        
        BSLog(@"系统出现异常，响应信息:\n%@",httpResponse);
        
        BSLog(@"系统出现异常，详细信息:\n%@",error);
        //如果是权限问题继续提交
        if ([localizedDescription containsString:@"401"]&&loginRetryNumber<AUTHORIZATION_RETRY) {
            //权限认证出现异常,则再次请求
            loginRetryNumber++;
             NSDictionary *dicLogin = [NSDictionary dictionaryWithObjectsAndKeys:loginUser.userName,@"username",
                loginUser.passWord,@"password", nil];
            [BSHTTPNetworking httpAuthorizationPOST:USER_LOGIN_SCHEMA
                           pathPattern:USER_LOGIN_SCHEMA
                            parameters:dicLogin
                            modelClass:[UserSession class]
                               keyPath:@""
                                 block:(BSHTTPResponse)block
             ];
            
            
            return ;
        }
        if (block&&loginRetryNumber>=AUTHORIZATION_RETRY) {
            
            [Conf handleNetworkError:error];
            if (errorUILabel) {
                //errorUILabel.text=error.description;
                //errorUILabel.text=localizedDescription;
            }else {
                //[BSUIComponentView
                // confirmUIAlertView:error.description];
                [BSUIComponentView
                 confirmUIAlertView:localizedDescription];

            }
        }
    };
}


@end
