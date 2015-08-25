//
//  EHNetwork.h
//
//  Created by Milo. on 14-11-1.
//  Copyright (c) 2015年 milodongg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetSuccessBlock)(NSString *resultString);
typedef void(^NetFailedBlock)(NSString *resultString);
typedef void(^NetProgressdBlock)(float progresFloat);

typedef void(^NetSuccessDataBlock)(NSData *resultData);
typedef void(^NetFailedDataBlock)(NSData *resultData);

@interface EHNetwork : NSObject

@property (nonatomic, strong) NSNumber *progressNumber;

/** 是否正在下载*/
@property (nonatomic, readonly, getter = isDownloading) BOOL downloading;

-(void)postDataWithUrl:(NSString *)aConnectURL
     withPostDictonary:(NSDictionary *)aPostDic
   withCompletionBlock:(NetSuccessBlock)aSuccessBlock
       withFailedBlock:(NetFailedBlock)aFailedBlock;

-(void)postDataWithUrl:(NSString *)aConnectURL
     withPostDictonary:(NSDictionary *)aPostDic
   withCompletionBlock:(NetSuccessBlock)aSuccessBlock
       withFailedBlock:(NetFailedBlock)aFailedBlock
   withUpProgressBlock:(NetProgressdBlock)aUpProgressBlock
 withDownProgressBlock:(NetProgressdBlock)aDownProgressBlock
              withDate:(double)timeOutSeconds;

- (void)getZipFileWithUrl:(NSString *)aConnectURL
             withFilePath:(NSString *)filePath
      withCompletionBlock:(NetSuccessDataBlock)aSuccessBlock
          withFailedBlock:(NetFailedDataBlock)aFailedBlock
    withDownProgressBlock:(NetProgressdBlock)aDownProgressBlock;

- (void)getAvatarFileWithUrl:(NSString *)aUrl
            withSuccessBlock:(NetSuccessDataBlock)aSuccessBlock
             withFailedBlcok:(NetFailedDataBlock)aFailedBlock;

-(void)cancelNetwork;

// 下载文件
- (void)downFileUrl:(NSString *)url
       withFilePath:(NSString *)filePath
withCompletionBlock:(NetSuccessBlock)aSuccessBlock
    withFailedBlock:(NetFailedBlock)aFailedBlock
  withProgressBlock:(NetProgressdBlock)aProgressBlock;

/**
 * 暂停下载
 */
- (void)pause;

/**
 * 开始(恢复)下载
 */
- (void)start;

-(id)initWithKey:(NSString *)aEnhanceKey;
- (NSString *)getEnhanceKey;
@end
