//
//  EHNetwork.m
//
//  Created by Milo. on 14-11-1.
//  Copyright (c) 2015年 milodongg. All rights reserved.
//

#import "EHNetwork.h"
#import "AFNetworking.h"

@interface EHNetwork ()

//@property (nonatomic, strong) NetProgressdBlock progressBlock;
//@property (nonatomic, strong) NetSuccessBlock successBlock;
//@property (nonatomic, strong) NetFailedBlock failedBlock;

@property (nonatomic,strong) NSString         *mEnhance_workKey;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic,strong) NSNumber                *mProgressNumber;

@end

@implementation EHNetwork

-(id)initWithKey:(NSString *)aEnhanceKey
{
    if (self = [super init]) {
        self.mEnhance_workKey = aEnhanceKey;
    }
    return self;
}

- (void)dealloc
{
    [self cancelNetwork];
    //progressBlock = nil;
}

- (void)postDataWithUrl:(NSString *)aConnectURL
      withPostDictonary:(NSDictionary *)aPostDic
    withCompletionBlock:(NetSuccessBlock)aSuccessBlock
        withFailedBlock:(NetFailedBlock)aFailedBlock
{
    NSString *url = aConnectURL;
    
    NSLog(@"\n地址: %@\n", url);
    NSLog(@"\n参数: %@ \n", aPostDic);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *urlStr = [[NSURL URLWithString:url relativeToURL:manager.baseURL] absoluteString];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:urlStr parameters:aPostDic error:nil];
 
    self.operation = [manager HTTPRequestOperationWithRequest:request
                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          if (aSuccessBlock) {
                                                              aSuccessBlock(operation.responseString);
                                                          }
                                                      }
                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                          NSLog(@"请求失败---%@", error);
                                                          if (aFailedBlock) {
                                                              aFailedBlock(operation.responseString);
                                                          }
                                                      }];
    
    [manager.operationQueue addOperation:self.operation];
}

- (void)postDataWithUrl:(NSString *)aConnectURL
      withPostDictonary:(NSDictionary *)aPostDic
    withCompletionBlock:(NetSuccessBlock)aSuccessBlock
        withFailedBlock:(NetFailedBlock)aFailedBlock
    withUpProgressBlock:(NetProgressdBlock)aUpProgressBlock
  withDownProgressBlock:(NetProgressdBlock)aDownProgressBlock
               withDate:(double)timeOutSeconds
{
    NSString *url = aConnectURL;
    
    NSLog(@"\n地址: %@\n", url);
    NSLog(@"\n参数: %@ \n", aPostDic);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:url relativeToURL:manager.baseURL] absoluteString] parameters:aPostDic error:nil];
    self.operation = [manager HTTPRequestOperationWithRequest:request
                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          if (aSuccessBlock) {
                                                              aSuccessBlock(operation.responseString);
                                                          }
                                                      }
                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                          NSLog(@"请求失败---%@", error);
                                                          if (aFailedBlock) {
                                                              aFailedBlock(operation.responseString);
                                                          }
                                                      }];
    
    
    // 进度回调
    [self.operation setUploadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (aUpProgressBlock) {
            float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
            aUpProgressBlock(progress);
        }
    }];
    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (aDownProgressBlock) {
            float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
            aDownProgressBlock(progress);
        }
    }];
    //self.networkRequest.timeOutSeconds = timeOutSeconds;
    
    [manager.operationQueue addOperation:self.operation];
}

- (void)getZipFileWithUrl:(NSString *)aConnectURL
             withFilePath:(NSString *)filePath
      withCompletionBlock:(NetSuccessDataBlock)aSuccessBlock
          withFailedBlock:(NetFailedDataBlock)aFailedBlock
    withDownProgressBlock:(NetProgressdBlock)aDownProgressBlock
{
    NSString *url = aConnectURL;
    
    NSLog(@"\n地址: %@\n", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/zip"];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST"
                                                                      URLString:[[NSURL URLWithString:url relativeToURL:manager.baseURL] absoluteString]
                                                                     parameters:nil
                                                                          error:nil];
    self.operation = [manager HTTPRequestOperationWithRequest:request
                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          if (aSuccessBlock) {
                                                              aSuccessBlock(operation.responseData);
                                                          }
                                                      }
                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                          NSLog(@"下载失败--%@\n", error);
                                                          if (aFailedBlock) {
                                                              aFailedBlock(operation.responseData);
                                                          }
                                                      }];
    
    // 下载路径
    self.operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
    
    // 进度回调
    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (aDownProgressBlock) {
            float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
            if (aDownProgressBlock) {
                aDownProgressBlock(progress);
            }
        }
    }];
    
    [manager.operationQueue addOperation:self.operation];
}

- (void)getAvatarFileWithUrl:(NSString *)aUrl
            withSuccessBlock:(NetSuccessDataBlock)aSuccessBlock
             withFailedBlcok:(NetFailedDataBlock)aFailedBlock
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aUrl]];
    [urlRequest setHTTPMethod:@"POST"];
    
    // Add the header info
    [urlRequest addValue:@"http://gre.kaomanfen.com/" forHTTPHeaderField: @"Referer"];
    
    self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    // 成功和失败回调
    [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (aSuccessBlock) {
            aSuccessBlock(responseObject);
        }
    }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"下载失败--%@\n", error);
                                              if (aFailedBlock) {
                                                  aFailedBlock(operation.responseData);
                                              }
                                          }];
    
    [self.operation start];
}

- (void)cancelNetwork
{
    [self.operation cancel];
    self.operation = nil;
}

// 上传文件
- (void)upFileUrl:(NSString *)url
     withFilePath:(NSString *)destPath
withCompletionBlock:(NetSuccessBlock)aSuccessBlock
  withFailedBlock:(NetFailedBlock)aFailedBlock
withProgressBlock:(NetProgressdBlock)aProgressBlock
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *fileData = [NSData dataWithContentsOfFile:destPath];
        
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"filename" mimeType:@"audio/mp3"];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    //_uploadProgress = progress;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        //        if (aSuccessBlock) {
        //            aSuccessBlock(responseBlock, error);
        //        }
    }];
    
    [uploadTask resume];
}

/**
 *  下载文件，最好是zip文件
 *
 *  @param url      下载地址
 *  @param destPath 文件存储路径
 *  @param fileName 文件名
 */
- (void)downFileUrl:(NSString *)url
       withFilePath:(NSString *)filePath
withCompletionBlock:(NetSuccessBlock)aSuccessBlock
    withFailedBlock:(NetFailedBlock)aFailedBlock
  withProgressBlock:(NetProgressdBlock)aProgressBlock
{
    NSString *downloadUrl = url;
    NSString *downloadPath = filePath;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    
    // 检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
        
        // 获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:downloadPath];
        if (downloadedBytes > 0) {
            
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            
            request = mutableURLRequest;
            
        }
    }
    
    // 不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    // 下载请求
    self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // 下载路径
    self.operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:YES];
    
    __block typeof(self)bself = self;
    // 下载进度回调
    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // 下载进度
        float progress = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
        if (aProgressBlock) {
            aProgressBlock(progress);
            bself.mProgressNumber = [NSNumber numberWithFloat:progress];
        }
    }];
    
    // 成功和失败回调
    [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"下载完成路径--%@\n", downloadPath);
        if (aSuccessBlock) {
            aSuccessBlock(responseObject);
        }
    }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"下载失败--%@\n", error);
                                              if (aFailedBlock) {
                                                  aFailedBlock(operation.responseString);
                                              }
                                          }];
    
    [self.operation start];
    _downloading = YES;
}

/**
 * 开始(恢复)下载
 */
- (void)start
{
    [self.operation start];
    _downloading = YES;
}

/**
 * 暂停下载
 */
- (void)pause
{
    [self.operation pause];
    _downloading = NO;
}

// 获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path
{
    signed long long fileSize = 0;
    
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSError *error = nil;
        
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

- (NSString *)getEnhanceKey
{
    return self.mEnhance_workKey;
}
@end


