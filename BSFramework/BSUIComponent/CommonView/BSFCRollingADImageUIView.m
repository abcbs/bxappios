//
//  ADTImagePlayer.m
//  andaotong
//
//  Created by Gavin on 14-7-24.
//  Copyright (c) 2014年 adt. All rights reserved.
//

#import "BSFCRollingADImageUIView.h"
#import "BSUIFrameworkHeader.h"

@implementation ImageAndURLModel

-(NSString *)urlPictute
{
    _urlPictute = [_urlPictute stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return _urlPictute;
}

-(NSString *)urlVideo
{
    _urlVideo = [_urlVideo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return _urlVideo;
}

@end



@interface BSFCRollingADImageUIView() <UIScrollViewDelegate>
{
    NSInteger _count;
    NSInteger _valueToBottom;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;



@end

@implementation BSFCRollingADImageUIView

+(BSFCRollingADImageUIView *)initADImageUIViewWith:(NSMutableArray *)imagesNames
                                    playerDelegate:(id<BSImagePlayerDelegate> )player
                                              urls:(NSMutableArray *)urls
{
    
    BSFCRollingADImageUIView *imagePlayer = [BSFCRollingADImageUIView imagePlayer];
    
    [imagePlayer setPageControlPositionToBottom:40];
    [imagePlayer setImageNames:imagesNames];
    
    imagePlayer.playerDelegate = player;
   
    return imagePlayer;
    
}

+ (instancetype)imagePlayer
{

    return [[[NSBundle mainBundle] loadNibNamed:@"ADTImagePlayer" owner:nil options:nil] lastObject];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setImageAndURLModels:(NSArray *)imageAndURLModels
{
    _imageAndURLModels = imageAndURLModels;
    NSInteger count = imageAndURLModels.count;
    _count = count;
    // 1.添加图片到scrollView中
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSURL *picURL = [NSURL URLWithString:[imageAndURLModels[i] urlPictute]];
        [imageView setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"entertaiment_kong_back.png"]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkToURL:)];
        [imageView addGestureRecognizer:tapGester];
        [self.scrollView addSubview:imageView];
    }
    // 3.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    // 5.设置pageControl的总页数
    self.pageControl.numberOfPages = count;
    [self setNeedsLayout];
    
     self.pageControl.width=BSMarginY(SCREEN_WIDTH);
    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
    [self setNeedsLayout];
}

- (void)linkToURL:(UITapGestureRecognizer *)gester
{
    NSString *urlStr = [self.imageAndURLModels[gester.view.tag] urlVideo];
    if (urlStr != nil) {
        if ([self.playerDelegate respondsToSelector:@selector(imagePlayer:willLoadURL:)]) {
            [self.playerDelegate imagePlayer:self willLoadURL:[NSURL URLWithString:urlStr]];
        }
    }
}

-(void)setImageURLs:(NSArray *)imageURLs
{
    if (imageURLs == nil || imageURLs.count == 0) {
        [self removeTimer];
        return;
    }
    _imageURLs = imageURLs;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = imageURLs.count;
    _count = count;
    // 1.添加图片到scrollView中
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entertaiment_kong_back.png"]];
//        ADTLog(@"%@", imageURLs[i]);
        [imageView setImageWithURL:[NSURL URLWithString:imageURLs[i]]];
        [self.scrollView addSubview:imageView];
    }
    // 3.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    // 5.设置pageControl的总页数
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = 0;
    
    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
    [self setNeedsLayout];
}

-(void)setImageNames:(NSArray *)imageNames
{
    
    if (imageNames == nil || imageNames.count == 0) {
        [self removeTimer];
        return;
    }
    
    _imageNames = imageNames;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = imageNames.count;
     _count = count;
    // 1.添加图片到scrollView中
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entertaiment_kong_back.png"]];
        
        imageView.image = [UIImage imageNamed:self.imageNames[i]];
        [self.scrollView addSubview:imageView];
    }
    // 3.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    // 5.设置pageControl的总页数
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = 0;
    //适配修改
    self.scrollView.width=BSMarginX(SCREEN_WIDTH);
    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
    //[self setNeedsLayout];
//    [self layoutSubviews];
    
}



/**
 *  添加定时器
 */
- (void)addTimer
{
    [self removeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextImage
{
    // 1.增加pageControl的页码
    int page = 0;
    if (self.pageControl.currentPage >=  _count - 1) {
        page = 0;
    } else {
        page = (int)self.pageControl.currentPage + 1;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * self.scrollView.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;

}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self addTimer];
}


- (void)setPageControlPositionToBottom:(NSInteger)value
{
    _valueToBottom = value;
    [self setNeedsDisplay];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageW = self.scrollView.width;
    CGFloat imageH = self.scrollView.height;
    
    CGFloat imageY = 0;
    NSInteger count =  _count;
    // 1.添加图片到scrollView中
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
   
    }
    
    self.pageControl.y = self.height - _valueToBottom;
    
    // 2.设置内容尺寸
    CGFloat contentW = count * imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
}


@end
