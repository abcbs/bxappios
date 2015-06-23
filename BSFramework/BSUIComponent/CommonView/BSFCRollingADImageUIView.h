//
//  ADTImagePlayer.h
//
//  Created by Gavin on 14-7-24.
//  Copyright (c) 2014年 adt. All rights reserved.
///  图片轮播器的封装

#import <UIKit/UIKit.h>


/**
 *  用作带图片和对应链接的需求模型
 */
@interface ImageAndURLModel : NSObject
/**
 *  图片URL
 */
@property (nonatomic, copy) NSString *urlPictute;
/**
 *  图片单击跳转URL
 */
@property (nonatomic, copy) NSString *urlVideo;

@end


@class BSFCRollingADImageUIView;

@protocol BSImagePlayerDelegate <NSObject>

@optional
- (void)imagePlayer:(BSFCRollingADImageUIView *)imagePlayer willLoadURL:(NSURL *)URL;

@end


@interface BSFCRollingADImageUIView : UIView

@property (nonatomic, weak) id <BSImagePlayerDelegate> playerDelegate;

/**
 *  根据图片名称进行创建
 */
@property (nonatomic, strong) NSArray *imageNames;

/**
 *  根据图片URL路径创建
 */
@property (nonatomic, strong) NSArray *imageURLs;
/**
 *  ImageAndURLModel
 */

/**
 *  根据图片url 和单击后 url模型创建(ImageAndURLModel)
 */
@property (nonatomic, strong) NSArray *imageAndURLModels;



+ (instancetype)imagePlayer;

+(BSFCRollingADImageUIView *)initADImageUIViewWith:(NSMutableArray *)imagesNames
                                    playerDelegate:(id<BSImagePlayerDelegate> )player
                                              urls:(NSMutableArray *)urls;

/**
 *  设置pageControl距离底部的位置
 *
 *  @param value 点距离
 */
- (void)setPageControlPositionToBottom:(NSInteger)value;


/**
 *  移除定时器
 */
- (void)removeTimer;

/**
 *  添加定时器
 */
- (void)addTimer;

@end
