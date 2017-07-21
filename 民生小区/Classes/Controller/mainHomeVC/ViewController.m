//
//  ViewController.m
//  民生小区
//
//  Created by L on 15/4/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

   

    int count = 6;
    CGFloat imgW = kScreenWidth;
    CGFloat imgH = 130;
    for (int i = 0; i < count; i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        
        NSString *imgName = [NSString stringWithFormat:@"img_%02d", i+1];
        imageView.image = [UIImage imageNamed:imgName];
        //frame
        CGFloat imgY = 0;
        CGFloat imgX = i * imgW;
        imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
    }
    
    // 设置返回按钮title
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    
    //设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(count * imgW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //3.启用分业
    self.scrollView.pagingEnabled = YES;
  
    //设置分业控件
    self.pageControl.numberOfPages = count;
    
    //5.设置代理
    self.scrollView.delegate = self;
    
    //6.定时器
    [self startTimer];
    
  // 进入商品界面
    UIButton *enterPru = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterPru setTitle:@"" forState:UIControlStateNormal];
    [enterPru setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    enterPru .frame = CGRectMake(30, 400, 80, 40);
    [enterPru addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterPru];
    
    
}
- (void)enterClick
{
    TableViewController *tb = [[TableViewController alloc]init];
    [self.navigationController pushViewController:tb animated:YES];
}
-(void)nextImage
{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1){
        page = 0;
    }else{
        page++;
    }
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0)animated:YES];
    
}
#pragma mark - scrollView的代理方法
//正在滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当前页面
    int page = (scrollView.contentOffset.x + 0.5 * scrollView.frame.size.width) / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
    
}

//开始滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self stopTimer];
}
//停止滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

/**
 *  开始定时器
 */
-(void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
-(void)stopTimer;
{
    [self.timer invalidate];
}
@end
