//
//  KTlifeViewController.m
//  生活小区主页控制器
//
//  Created by 罗芳芳 on 15/4/23.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTlifeViewController.h"
#import "KTLifeSearchBar.h"
#import "KTTarBarController.h"
#import "UIView+Frame.h"
#import "Conf.h"
#import "TableViewController.h"
#import "AppDelegate.h"
#import "BSFCRollingADImageUIView.h"

@interface KTlifeViewController ()<UITextFieldDelegate,UITableViewDelegate,BSImagePlayerDelegate>
{
   
    
    
}
@property (nonatomic, strong)KTLifeSearchBar *searchBar;
@property (nonatomic,strong) UIScrollView *BigScrollView;

@end

@implementation KTlifeViewController

@synthesize imagePlayer;


- (void)viewDidLoad {
    
   [super viewDidLoad];
   [Conf navigationControllerHeader:self.navigationController ];
   [AppDelegate storyBoradAutoLay:self.view];
    _BigScrollView =[[UIScrollView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X,NAVIGATIONBAR_HEIGHT+178 , SCREEN_WIDTH,SCREEN_HEIGHT*0.7)];
   _BigScrollView.contentSize=BSSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT + 400);
   _BigScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
   _BigScrollView.showsVerticalScrollIndicator = NO;
    
   [self.view addSubview:_BigScrollView];
   
   [self initCommonTools];
   // 初始化图片轮播起
   [self initImgPlay];
   [self initTwo];
   
   
}

- (BOOL)prefersStatusBarHidden
{
   return NO;
}

//2个按钮
-(void)initTwo
{
   UIButton *titBtn = [[UIButton alloc]initWithFrame:BSRectMake(15, 156 , 100, 26)];
   [titBtn setImage:[UIImage imageNamed:@"xy"] forState:UIControlStateNormal];
   [titBtn setTitle:@"预约服务" forState:UIControlStateNormal];
   [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   titBtn.userInteractionEnabled = NO;// 为了方便一个前面的点,后面是文字,就用了uibutton  然后把用户交互关了
   [_BigScrollView addSubview:titBtn];
   
   
   CGFloat X = 10;
   CGFloat Y = 190 ;
   //SMview.frame = CGRectMake(X, Y,300 , 110);
    
   UIView *SMview = [[UIView alloc]initWithFrame:BSRectMake(X, Y,300 , 80)];
    
    SMview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
   NSArray *tuPian = [NSArray arrayWithObjects:@"98xc",@"98ss",nil];
   NSArray *mingzi = [NSArray arrayWithObjects:@"洗车",@"送水",nil];
   for(int i=0;i<2;i++)
   {
      UIButton *btn = [[UIButton alloc]init];
      CGFloat margin = ((SCREEN_WIDTH / 4) - 50)/2;
      CGFloat x = margin + ((margin *2) + 40) * i;
      CGFloat y = 10;
      if(i>=4)
      {
         y = 90;
         x = margin + ((margin *2) + 30) * (i - 4);
      }
      CGFloat w = 32;
      CGFloat h = 32;
      btn.frame = BSRectMake(x, y, w, h);
      [btn setImage:[UIImage imageNamed:tuPian[i]] forState:UIControlStateNormal];
      btn.tag = i + 100;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [SMview addSubview:btn];
      UILabel *lab = [[UILabel alloc]init];
      lab.text = mingzi[i];
      lab.frame = BSRectMake(x+2, y+32, w, 20);
      lab.font = [UIFont systemFontOfSize:12];
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
   
   UIButton *titBtn = [[UIButton alloc]initWithFrame:BSRectMake(10,  0 , 90,26)];
   [titBtn setImage:[UIImage imageNamed:@"xy"] forState:UIControlStateNormal];
  
   [titBtn setTitle:@"便捷服务" forState:UIControlStateNormal];
   [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   titBtn.userInteractionEnabled = NO;// 为了方便一个前面的点,后面是文字,就用了uibutton  然后把用户交互关了
   [_BigScrollView addSubview:titBtn];
   
   UIView *BGview = [[UIView alloc]init];
   CGFloat X = 10;
   CGFloat Y = 30 ;
   BGview.frame = BSRectMake(X, Y,300 , 120);
   BGview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
   NSArray *tuPian = [NSArray arrayWithObjects:@"98xc",@"98ss",@"98bj",@"98cs",@"98jz",nil];
   NSArray *mingzi = [NSArray arrayWithObjects:@"洗车",@"送水",@"保洁",@"超市",@"家政",nil];
   for(int i=0;i<5;i++)
   {
      UIButton *btn = [[UIButton alloc]init];
      CGFloat margin = ((SCREEN_WIDTH / 4) - 50)/2;
      CGFloat x = BSMarginX(margin) + ((BSMarginX(margin )*2) + BSMarginX(35)) * i;
      CGFloat y = 6;
      if(i>=4)
      {
         y = 64;
         x = BSMarginX(margin) + ((BSMarginX(margin ) *2) + BSMarginX(35)) * (i - 4);
      }
      CGFloat w = 32;
      CGFloat h = 32;
      btn.frame = BSRectMake(x, y, w, h);
      [btn setImage:[UIImage imageNamed:tuPian[i]] forState:UIControlStateNormal];
      btn.tag = i + 100;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [BGview addSubview:btn];
      UILabel *lab = [[UILabel alloc]init];
      lab.text = mingzi[i];
      lab.frame = BSRectMake(x+2, y+32, w, 20);
      lab.font = [UIFont systemFontOfSize:12];
      [BGview addSubview:lab];

       
   }
   BGview.layer.borderWidth = 1;    // 这边写边框的粗细
   BGview.layer.borderColor = [[UIColor grayColor]CGColor];
   BGview.layer.masksToBounds = YES;
   BGview.layer.cornerRadius = 5;// 边框的圆角
   
   
   [_BigScrollView addSubview:BGview];
   
   
}

- (void)btnClick:(UIButton *)btn
{
     UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    
    TableViewController *shoppControl = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    
    UINavigationController* nav = [[UINavigationController alloc]  initWithRootViewController:shoppControl];
    
    [self presentViewController:nav animated:YES completion:nil];
    
     
}


//图片轮播起//
- (void)initImgPlay{

    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++){
        NSString *imgName = [NSString stringWithFormat:@"img_0%d.jpg",i+1];
        [tempArray addObject:imgName];
    }
    
   [self.imagePlayer addSubview: [BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil]];
   //view.frame=BSRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.3);
    
   // [_BigScrollView addSubview:view];
   //self.scrollView = scV;
    
}

@end
