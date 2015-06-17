//
//  KTWaterDetailsViewController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#import "UIImageView+WebCache.h"
#import "MSWaterSendingCell.h"
#import "WaterSending.h"
#import "KTWaterDetailsViewController.h"
#import "AFNetworking.h"
#import "WaterSendingDetails.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#import "KTCartTableView.h"
#import "Comment.h"
#import "WaterSendingDetails.h"
#import "LoginViewController.h"
#import "ShoppingCart.h"
#import "CartList.h"
#import "KTCarCell.h"
#import "CommodityEvaluationRequest.h"
#import "JoinShoppingCartRequest.h"
#import "ViewShoppingCartResult.h"

@interface KTWaterDetailsViewController ()


@property (weak, nonatomic) IBOutlet UILabel *introduce;

@property (weak, nonatomic) IBOutlet UILabel *preferPrice;

@property (weak, nonatomic) IBOutlet UILabel *salePrice;

@property (weak, nonatomic) IBOutlet UILabel *unitPrice;


@property (weak, nonatomic) IBOutlet UIButton *carNumText;


@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *username;

- (IBAction)addCart:(id)sender;
- (IBAction)watchMore:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KTWaterDetailsViewController

@synthesize shoppingCart;

-(void)viewDidLoad {
    [super viewDidLoad];
    if (shoppingCart==nil) {
        shoppingCart=[[ShoppingCart alloc]init];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化图片轮播起
   [self initImgPlay];
    //商品详细信息
    [self waterDetail];
    
    [self productcomments];
}


- (void)initImgPlay{
   
        //循环生成5张图片，依次添加到scrollView中
    int count = 3;
    CGFloat imgW = 150;
    CGFloat imgH = 150;
    for (int i = 0; i < count; i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        //
        NSString *imgName = [NSString stringWithFormat:@"img_%02d",i+1];
        imageView.image = [UIImage imageNamed:imgName];
        
        //frame
        CGFloat imgY = 0;
        CGFloat imgX = i * imgW;
        imageView.frame = CGRectMake(imgX, imgY,imgW, imgH);
    }
    
    //2设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(count * imgW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //3.启用分页
    self.scrollView.pagingEnabled = YES;
    
    //设置分页控件
    self.pageControl.numberOfPages = count;
    
    //5.设置代理
    self.scrollView.delegate = self;
    
    //6.定时器
    [self startTimer];
    
    
    
}

-(void)nextImage
{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1){
        page = 0;
    }else{
        page++;
    }
    //self.pageControl.currentPage = page;
    
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width,0)animated:YES];
}
#pragma mark - scrollView的代理方法
//正在滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当前页面
    int page = (scrollView.contentOffset.x + 0.5 *scrollView.frame.size.width)/scrollView.frame.size.width;
    self.pageControl.currentPage = page;
    
}
//开始滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
//停止滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
    
}

/**
 *   开启定时器
 */
-(void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0  target:self selector:@selector(nextImage)userInfo:nil repeats:YES];
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    
   }
-(void)stopTimer
{
    
    [self.timer invalidate];
    
    
}


#pragma mark  ---  商品详细信息
- (void)waterDetail {
    
  
    self.introduce.text =  self.waterSending.introduce;
    
    self.unitPrice.text =  [NSString stringWithFormat:@"￥%d", self.waterSending.unitPrice ];
    
    self.salePrice.text =[NSString stringWithFormat:@"￥%d",self.waterSending.salePrice];
    
    self.preferPrice.text =[NSString stringWithFormat:@"￥%d",self.waterSending.preferPrice];


}

#pragma mark  ---  商品评价
- (void)productcomments {
    [self loadCommentData:1];

}



- (IBAction)addCart:(id)sender {
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sessionID = [userDefaults objectForKey:@"sessionId"];
    if (sessionID.length == 0) {
        //没登陆。跳转到登陆界面
        // self.presentedViewController.LoginViewController
        LoginViewController  *nv = [[LoginViewController  alloc]init];
        
        [self presentViewController:nv animated:YES completion:nil];
    }
   
    else
    {
        //调用服务端接口
        [self addCard:sessionID  addCount:self.carNumText.titleLabel.text
                addID:[[NSNumber alloc] initWithLong:self.waterSending.id]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"加入购物车成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"进入购物车", nil];
        
        [alertView show];
        
    }
}


-(void) addCard:(NSString *)sessionId
       addCount:(NSString *)addCount addID:(NSNumber *)ptid
{

    shoppingCart.sessionId=sessionId;
    shoppingCart.countorder=addCount;
    shoppingCart.businessProductId=ptid;
    shoppingCart.id =self.waterSending.id;
    
    [ShoppingCart addCart:shoppingCart
               blockArray:^(NSObject *response,NSError *error,ErrorMessage *errorMessage){
                        shoppingCart.currentCount=(NSNumber *)response;
                   
                   [self.carNumText setTitle:[NSString stringWithFormat:@"%d",[(NSNumber *)response intValue ]] forState:UIControlStateNormal];
                }
     
     ];

}

#pragma mark UIAlertdelegate代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 你试试是0还是1     取消就取消
    }else if(buttonIndex == 1){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTCartTableView" bundle:nil];
        
        KTCartTableView *login = [storyboard instantiateInitialViewController];

        
        [self presentViewController:login animated:YES completion:nil];
        
        
    }
}

- (IBAction)watchMore:(id)sender {
}



#pragma mark  ---  网络请求
- (void)loadCommentData:(int)cellCount
{    
    [WaterSendingDetails listComments:self.waterSending maxId:1
                            dataCount:cellCount
                            errorUILabel:self.username
    //块的使用方式
    blockArray:^(NSObject *waterSendingDetails, NSError *error,ErrorMessage *errorMessage) {
            self.waterSendingDetails=(WaterSendingDetails *)waterSendingDetails;
            Comment * cmm=[[self.waterSendingDetails comments] firstObject];
            self.comment.text=[cmm comment];
            self.username.text=[cmm username];
     

        }
     ];

}


/*
-(long )firstDataId{
    WaterSending *ws=[self.waterSendings firstObject];
    return ws.id;
}

-(long )lastDataId{
    WaterSending *ws=[self.waterSendings lastObject];
    return ws.id;
}
 
-(int )pageCount{
    return 10;
}
*/

/**
 *数量增加
 */
- (IBAction)plusCarNum:(UIButton *)sender {
    

    int currentCount = (int)[self.carNumText.titleLabel.text integerValue];
    currentCount++;
    [self.carNumText setTitle:[NSString stringWithFormat:@"%d",currentCount] forState:UIControlStateNormal];
    



}
/**
 *数量减少
 */
- (IBAction)cutCarNum:(UIButton *)sender {

    int currentCount = (int)[self.carNumText.titleLabel.text integerValue];
    currentCount--;
    if(currentCount<=0)
    {
        currentCount = 0;
    }
    [self.carNumText setTitle:[NSString stringWithFormat:@"%d",currentCount] forState:UIControlStateNormal];
}

//判断是否为整形
-(BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


@end
