//
//  ADTImagePlayer.m
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSFCRollingADImageUIView.h"
#import "BSUIFrameworkHeader.h"


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

+(BSFCRollingADImageUIView *)initADWithImages:(NSMutableArray *)images
                                    playerDelegate:(id<BSImagePlayerDelegate> )player
 target:(UIViewController*)controller
                                             width:(CGFloat) w height:(CGFloat) h{
    BSFCRollingADImageUIView *imagePlayer = [BSFCRollingADImageUIView imagePlayer];
    //长宽，默认
    imagePlayer.width=BSMarginX( w);
    imagePlayer.height=BSMarginY(h);
    imagePlayer.targetController=controller;
    [imagePlayer setPageControlPositionToBottom:40];
    //图片的URL数组
    [imagePlayer setImages:images];
    
    imagePlayer.playerDelegate = player;
    
    return imagePlayer;

    
}

+(BSFCRollingADImageUIView *)initADWithImagesDefaultWH:(NSMutableArray *)images
                                        playerDelegate:(id<BSImagePlayerDelegate> )player
                                                target:(UIViewController*)controller{
    return [BSFCRollingADImageUIView initADWithImages:images
       playerDelegate:player
       target:controller
       width:SCREEN_WIDTH height:SCREEN_HEIGHT ];
}

+(BSFCRollingADImageUIView *)initADImageUIViewWith:(NSMutableArray *)imagesNames
playerDelegate:(id<BSImagePlayerDelegate> )player
urls:(NSMutableArray *)urls
BSDeprecated("废除，下版本合并将删除此方法")
{
    BSFCRollingADImageUIView *imagePlayer = [BSFCRollingADImageUIView imagePlayer];
    //长宽，默认
    imagePlayer.width=BSMarginX( SCREEN_WIDTH);
    imagePlayer.height=BSMarginY(SCREEN_HEIGHT);
    
    [imagePlayer setPageControlPositionToBottom:40];
    //图片的URL数组
    [imagePlayer setImageNames:imagesNames];
    
    imagePlayer.playerDelegate = player;
   
    return imagePlayer;
    
}

+ (instancetype)imagePlayer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADTImagePlayer" owner:nil options:nil] lastObject];
}


/**
 *默认轮播图，不带跳转信息，URL的Image名称
 */
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
    //self.scrollView.width=_width;
    [self setNeedsLayout];
    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
    
}

/**
 *默认轮播图，不带跳转信息，需要具体事件响应跳转信息
 */
-(void)setImages:(NSArray *)images
{
    
    if (images == nil || images.count == 0) {
        [self removeTimer];
        return;
    }
    
    _imageNames = images;
   
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = images.count;
     _count = count;
    // 1.添加图片到scrollView中
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entertaiment_kong_back.png"]];
        UIImage *image= self.imageNames[i];
        imageView.image =image;
        
        UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc] initWithTarget:_targetController
            action:@selector(touchAction:)];
        [imageView addGestureRecognizer:tapGester];
        
        imageView.userInteractionEnabled = YES;
        imageView.tag=i;
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
    self.scrollView.width=_width;
    self.scrollView.height=_height;
    self.scrollView.size=BSSizeMake(_width, _height);

    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
    
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
    CGFloat offsetX = page * _width;//self.scrollView.width;
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
    CGFloat scrollW = _width;
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

/**
 *轮播图显示样式
 */

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageW = self.scrollView.width;
    CGFloat imageH = self.scrollView.height;
    if (_width!=SCREEN_WIDTH) {
        imageW = _width;
        imageH =_height;
    }
    CGFloat imageY = 0;
    NSInteger count =  _count;
    // 1.添加图片到scrollView中
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (_width==SCREEN_WIDTH) {
            imageView.contentMode=UIViewContentModeScaleAspectFill;
        }else{
            imageView.contentMode = UIViewContentModeScaleToFill;
        }
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = BSRectMake(imageX, imageY, imageW, imageH);
    }
    
    self.pageControl.y = _height - _valueToBottom;
    
    // 2.设置内容尺寸
    CGFloat contentW = count * imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
}


- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
}
@end
