//
//  KTlifeViewController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/23.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTlifeViewController.h"
#import "KTLifeSearchBar.h"
#import "KTTarBarController.h"
#import "UIView+Frame.h"
#import "ViewController.h"
#import "TableViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
@interface KTlifeViewController ()<UITextFieldDelegate,UITableViewDelegate>
{
   

    
    
}
@property (nonatomic, strong)KTLifeSearchBar *searchBar;
@property (nonatomic,strong) UIScrollView *BigScrollView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) UITableView *ksTableView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation KTlifeViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   
   // 产品
   _BigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth,kScreenHight)];
   _BigScrollView.contentSize=CGSizeMake(kScreenWidth,kScreenHight + 400);
   _BigScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
   _BigScrollView.showsVerticalScrollIndicator = NO;
   [self.view addSubview:_BigScrollView];
   
   [self initCommonTools];
   // 初始化图片轮播起
   [self initImgPlay];
   
   [self initTopView];
   
   [self initTwo];
   
}

- (BOOL)prefersStatusBarHidden
{
   return NO;
}

- (void)initTopView
{
   // 隐藏导航条
   self.navigationController.navigationBar.hidden = YES;
   UIView *topView = [[UIView alloc]init];
   
   topView.backgroundColor = [UIColor colorWithRed:97/255.0 green:18/255.0 blue:15/255.0 alpha:1];
   topView.frame = CGRectMake(0, 0, kScreenWidth, 64);
   
   // 添加搜索框
   KTLifeSearchBar *searchBar =[[KTLifeSearchBar alloc] init];
   searchBar.centerX = kScreenWidth*0.5 - 70;
   searchBar.centerY = 60*0.5;
   searchBar.width = 180;
   searchBar.height = 30;
   searchBar.delegate = self;
   self.searchBar = searchBar;
   [topView addSubview:searchBar];
   // 左侧按钮
   UIButton *leftBtn = [[UIButton alloc]init];
   [leftBtn setTitle:@"生活圈" forState:UIControlStateNormal];
   leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
   [leftBtn setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
   leftBtn.frame = CGRectMake(0, 31, 80, 30);
   [topView addSubview:leftBtn];
   
   // 右侧按钮
   UIButton *rightBtn = [[UIButton alloc]init];
   [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_district"] forState:UIControlStateNormal];
   [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_map_highlighted"] forState:UIControlStateHighlighted];
   rightBtn.frame = CGRectMake(CGRectGetMaxX(searchBar.frame)+10, 27, 37, 37);
   [topView addSubview:rightBtn];
   [self.view addSubview:topView];
}

//2个按钮
-(void)initTwo
{
   UIButton *titBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 440 + 44 , 100, 26)];
   [titBtn setImage:[UIImage imageNamed:@"xy"] forState:UIControlStateNormal];
   [titBtn setTitle:@"预约服务" forState:UIControlStateNormal];
   [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   titBtn.userInteractionEnabled = NO;// 为了方便一个前面的点,后面是文字,就用了uibutton  然后把用户交互关了
   [_BigScrollView addSubview:titBtn];
   
   UIView *SMview = [[UIView alloc]init];
   CGFloat X = 10;
   CGFloat Y = 440 + 44 + 26;
   SMview.frame = CGRectMake(X, Y,300 , 110);
   SMview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
   NSArray *tuPian = [NSArray arrayWithObjects:@"98xc",@"98ss",nil];
   NSArray *mingzi = [NSArray arrayWithObjects:@"洗车",@"送水",nil];
   for(int i=0;i<2;i++)
   {
      UIButton *btn = [[UIButton alloc]init];
      CGFloat margin = ((kScreenWidth / 4) - 50)/2;
      CGFloat x = margin + ((margin *2) + 40) * i;
      CGFloat y = 10;
      if(i>=4)
      {
         y = 110;
         x = margin + ((margin *2) + 40) * (i - 4);
      }
      CGFloat w = 72;
      CGFloat h = 72;
      btn.frame = CGRectMake(x, y, w, h);
      [btn setImage:[UIImage imageNamed:tuPian[i]] forState:UIControlStateNormal];
      btn.tag = i + 100;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [SMview addSubview:btn];
      UILabel *lab = [[UILabel alloc]init];
      lab.text = mingzi[i];
      lab.frame = CGRectMake(x+20, y+68, w, 20);
      lab.font = [UIFont systemFontOfSize:14];
      [SMview addSubview:lab];
   }
   SMview.layer.borderWidth = 1;    // 边框的粗细
   SMview.layer.borderColor = [[UIColor grayColor]CGColor];
   SMview.layer.masksToBounds = YES;
   
   SMview.layer.cornerRadius = 5;// 边框的圆角
   
   
   [_BigScrollView addSubview:SMview];
   
   
}





// 5个按钮
- (void)initCommonTools
{
   
   UIButton *titBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 200 + 44 , 100,26)];
   [titBtn setImage:[UIImage imageNamed:@"xy"] forState:UIControlStateNormal];
  
   [titBtn setTitle:@"便捷服务" forState:UIControlStateNormal];
   [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   titBtn.userInteractionEnabled = NO;// 为了方便一个前面的点,后面是文字,就用了uibutton  然后把用户交互关了
   [_BigScrollView addSubview:titBtn];
   
   UIView *BGview = [[UIView alloc]init];
   CGFloat X = 10;
   CGFloat Y = 200 + 44 + 26;
   BGview.frame = CGRectMake(X, Y,300 , 200);
   BGview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
   NSArray *tuPian = [NSArray arrayWithObjects:@"98xc",@"98ss",@"98bj",@"98cs",@"98jz",nil];
   NSArray *mingzi = [NSArray arrayWithObjects:@"洗车",@"送水",@"保洁",@"超市",@"家政",nil];
   for(int i=0;i<5;i++)
   {
      UIButton *btn = [[UIButton alloc]init];
      CGFloat margin = ((kScreenWidth / 4) - 50)/2;
      CGFloat x = margin + ((margin *2) + 35) * i;
      CGFloat y = 10;
      if(i>=4)
      {
         y = 110;
         x = margin + ((margin *2) + 35) * (i - 4);
      }
      CGFloat w = 72;
      CGFloat h = 72;
      btn.frame = CGRectMake(x, y, w, h);
      [btn setImage:[UIImage imageNamed:tuPian[i]] forState:UIControlStateNormal];
      btn.tag = i + 100;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [BGview addSubview:btn];
      UILabel *lab = [[UILabel alloc]init];
      lab.text = mingzi[i];
      lab.frame = CGRectMake(x+20, y+68, w, 20);
      lab.font = [UIFont systemFontOfSize:16];
      [BGview addSubview:lab];
   }
   BGview.layer.borderWidth = 1;    // 这边写边框的粗细
   BGview.layer.borderColor = [[UIColor grayColor]CGColor];
   BGview.layer.masksToBounds = YES;
   BGview.layer.cornerRadius = 5;// 边框的圆角
   
   
   [_BigScrollView addSubview:BGview];
   
   
}

// 。。。。。垃圾代码
- (void)btnClick:(UIButton *)btn
{
   
   
   TableViewController *tableVC = [[TableViewController alloc]init];
   UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:tableVC];
   [self presentViewController:nav animated:YES completion:nil];
   // youcuo
}


//图片轮播起//
- (void)initImgPlay{
   
   UIScrollView *scV = [[UIScrollView alloc]init];
   scV.frame = CGRectMake(0, 64, kScreenWidth, kScreenHight *0.3);
   scV.backgroundColor = [UIColor redColor];
   
   [self.view addSubview:scV];
   self.scrollView = scV;
   
   int count = 6;
   CGFloat imgW = kScreenWidth;
   CGFloat imgH = kScreenHight *0.3;
   for (int i = 0; i < count; i++){
      UIImageView *imageView = [[UIImageView alloc] init];
      NSString *imgName = [NSString stringWithFormat:@"img_%02d", i+1];
      imageView.image = [UIImage imageNamed:imgName];
      
      //frame
      CGFloat imgY = 0;
      CGFloat imgX = i * imgW;
      imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
      [self.scrollView addSubview:imageView];
      
   }
   
   //设置scrollView的滚动范围
   self.scrollView.contentSize = CGSizeMake(count * imgW, imgH*0.3);
   
   self.scrollView.showsHorizontalScrollIndicator = NO;
   
   //3.启用分业
   self.scrollView.pagingEnabled = YES;
   
   //设置分业控件
   self.pageControl.numberOfPages = count;
   
   //5.设置代理
   self.scrollView.delegate = self;
   
   //6.定时器
   [self startTimer];
   
   
   
   // 添加page
   UIPageControl *pageVC = [[UIPageControl alloc]init];
   pageVC.numberOfPages = count;
   //   pageVC.frame = CGRectMake(0, imgH *0.8, 10, 10);
   pageVC.centerX = scV.width*0.5;
   pageVC.centerY = 64 + scV.height *0.93;
   pageVC.currentPageIndicatorTintColor = [UIColor yellowColor];
   pageVC.pageIndicatorTintColor = [UIColor blueColor];
   [_BigScrollView addSubview:_scrollView];
   [_BigScrollView addSubview:pageVC];
   self.pageControl = pageVC;
   
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
