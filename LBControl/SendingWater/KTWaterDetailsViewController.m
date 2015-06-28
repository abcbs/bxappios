//
//  KTWaterDetailsViewController.m
//  民生小区
//
//  Created by 罗芳芳 on 15/4/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIFrameworkHeader.h"

#import "UIImageView+WebCache.h"

#import "MSWaterSendingCell.h"
#import "WaterSending.h"
#import "KTWaterDetailsViewController.h"
#import "AFNetworking.h"
#import "WaterSendingDetails.h"


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




@interface KTWaterDetailsViewController ()<BSImagePlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *introduce;

@property (weak, nonatomic) IBOutlet UILabel *preferPrice;

@property (weak, nonatomic) IBOutlet UILabel *salePrice;

@property (weak, nonatomic) IBOutlet UILabel *unitPrice;


@property (weak, nonatomic) IBOutlet UIButton *carNumText;


@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *username;

- (IBAction)addCart:(id)sender;

- (IBAction)watchMore:(id)sender;

@property (weak, nonatomic) IBOutlet BSFCRollingADImageUIView *imagePlayer;

@end

@implementation KTWaterDetailsViewController

@synthesize shoppingCart;
@synthesize waterSending;


-(void)viewDidLoad {
    [super viewDidLoad];
    if (shoppingCart==nil) {
        shoppingCart=[[ShoppingCart alloc]init];
    }
   [BSUIComponentView navigationHeader:self.navigationController ];
    
    // 初始化图片轮播起
   [self initImgPlay];
    
    //商品详细信息
    [self waterDetail];
    
    [self productcomments];
}

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initImgPlay{

    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++){
        NSString *imgName = [NSString stringWithFormat:@"img_0%d.jpg",i+1];
        [tempArray addObject:imgName];
    }
    
    //修改轮播的实现方式
    UIView *imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil];
    
    [self.imagePlayer addSubview:imagePlayer];
    
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



#pragma mark  ---  获取评论信息
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


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];}
@end
