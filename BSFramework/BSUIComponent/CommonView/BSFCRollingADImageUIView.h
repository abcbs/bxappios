//
//  ADTImagePlayer.h
//
//  Created by Gavin on 14-7-24.
//  Copyright (c) 2014年 adt. All rights reserved.
///  图片轮播器的封装

#import <UIKit/UIKit.h>


@class BSFCRollingADImageUIView;

@protocol BSImagePlayerDelegate <NSObject>

@optional
- (void)imagePlayer:(BSFCRollingADImageUIView *)imagePlayer willLoadURL:(NSURL *)URL;

@end


@interface BSFCRollingADImageUIView : UIView

@property (nonatomic, weak) id <BSImagePlayerDelegate> playerDelegate;

@property (nonatomic, weak) UIViewController *targetController;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

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



+(BSFCRollingADImageUIView *)initADImageUIViewWith:(NSMutableArray *)imagesNames
   playerDelegate:(id<BSImagePlayerDelegate> )player
   urls:(NSMutableArray *)urls;

+(BSFCRollingADImageUIView *)initADImageUIViewWith:(NSMutableArray *)images
playerDelegate:(id<BSImagePlayerDelegate> )player
target:(UIViewController*)controller
width:(CGFloat) w height:(CGFloat) h;

+ (instancetype)imagePlayer;

-(void)touchAction:(UIGestureRecognizer *)gestureRecognizer;

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
