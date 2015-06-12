//
//  KTCartTableView.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTCartTableView.h"
#import "KTCarCell.h"
#import "KTCartFooterView.h"
#import "ShoppingCart.h"
#import "CartList.h"
#import "KTInformationConfViewController.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "EHNetwork.h"
#import "ViewShoppingCartRequest.h"
#import "ViewShoppingCartParams.h"






@interface KTCartTableView ()
//<UITableViewDelegate,UITableViewDataSource,KTFooterViewDelegate>
<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *KTCarttableView;
@property (weak, nonatomic) IBOutlet KTCartFooterView *cartFooterVIew;

@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *cardSumPrice;


- (IBAction)payCount:(UIButton *)sender;

@end

@implementation KTCartTableView

// 懒加载
- (NSArray *)modelList
{
    if(_modelList == nil)
    {
        _modelList = [NSMutableArray array];
        
    }
    return  _modelList;
}
-(IBAction)allSelectClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    NSArray* anArrayOfIndexPath = [NSArray arrayWithArray:[self.KTCarttableView indexPathsForVisibleRows]];
    for (NSInteger i = 0; i< anArrayOfIndexPath.count; i++) {
        NSIndexPath* indexPath = [anArrayOfIndexPath objectAtIndex:i];
        KTCarCell* cell = (KTCarCell *)[self.KTCarttableView cellForRowAtIndexPath:indexPath];
        cell.isSelect = sender.selected;
}
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"========%@",self.modelList);
      self.allSelectBtn.selected =NO;
    self.KTCarttableView.tableFooterView = [[UIView alloc]init];
   // self.cartFooterView.delegate = self;
    
    // 网络加载数据
    [self loadmore];
    
    
   [self ShoppingCart];
    
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return self.modelList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    KTCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   
       cell.isSelect = self.allSelectBtn.selected;
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KTCarCell" owner:nil options:nil] lastObject] ;
    }
    
//    cell = nil;
  
//    CartList *cartModel = self.modelList[indexPath.row];
    NSLog(@"--modelList--%@",self.modelList);

//         [_KTCarttableView reloadData];

//    cell.productName.text = cartModel.productName;
//    cell.productIntroduce.text = cartModel.productIntroduce;
//    cell.productSalePrice.text = cartModel.productSalePrice;
//    cell.productPreferPrice.text = cartModel.productPreferPrice;
//        cell.applyCallBack = ^void(NSInteger tag,BOOL isSelected){
//            CartList.selected = isSelected;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //CartList *cartlist = self.modelList[indexPath.row];
}

//设置行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
//-(void) ShoppingCart
//{

//     NSString *url =  @"http://192.168.2.103:8090/shoppingcart/usercarts/B31A6D7FFA55CDC53338404C0FD6E874";
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"访问成功 ===== %@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"网络访问失败======");
//        NSURLRequest *req = operation.request;
//        
//        //   NSURLResponse *rsp = operation.response;
//        NSString *reqbody = [[NSString alloc]initWithData:req.HTTPBody encoding:NSUTF8StringEncoding];
//        NSLog(@"Request URL %@ ",req.URL);
//        NSLog(@"Request body %@",reqbody);
//        
//        NSString *rspbody =[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"Response  %@",rspbody);
//    }];
//}
-(void) ShoppingCart{
    
 
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //
        NSString *sessionID = [userDefaults objectForKey:@"sessionId"];
            NSLog(@"%@========",sessionID);
        //    [CartList urlWithShoppingCart:sessionID
        //                       blockArray:^(NSMutableArray *waters, NSError *error,ErrorMessage *errorMessage){
        ////                           if (!error) {
        ////
        ////                               [self.waterSendingArray addObjectsFromArray:[CartList objectArrayWithKeyValuesArray:waters]];
        ////                           }
        ////                           if (errorMessage) {
        ////                               NSLog(@"已经是最后一条数据");
        ////                           }
        ////                       }
        ////     ];
        //
        ViewShoppingCartParams *params = [ViewShoppingCartParams param];
        params.sessionId = sessionID;
        
            [ViewShoppingCartRequest viewShoppingCartWith:params block:^(ViewShoppingCartResult *result, NSError *error, BasicHeader *headr) {
                if (result) {
        
                    NSLog(@"成功%@－－ json %@",result.responseHeader.message,result.responseBody);
                    for (ViewShoppingCartDict *dict in result.responseBody) {
                        NSLog(@"-商品详情-%@",dict.keyValues);
                    }
                }
        
                if (headr) {
                    NSLog(@"失败%@",headr.message);
                }
        
                if (error) {
                    NSLog(@"网络异常%ld ---- %@",(long)error.code,error.userInfo);
                }
        
        
            }];
    
   
}

  #pragma mark  ---  网络请求

- (void)loadmore
{
//    [CartList
//     cartList:(NSString *)cartId businessProductId:(NSString *)businessProductId
//     blockArray:^(NSMutableArray *warters, NSError *error,ErrorMessage *errorMessage) {
//         if (!error) {
//             NSArray *array = [self.modelList arrayByAddingObjectsFromArray:warters];
//             self.modelList = (NSMutableArray *)array;
//             [self.KTCarttableView reloadData];
//             [MBProgressHUD hideHUD];
//             // 关闭刷新提示
//             [self.KTCarttableView footerEndRefreshing];
//         }
//         
//     }
//     ];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sessionID = [userDefaults objectForKey:@"sessionId"];
    [CartList urlWithShoppingCart:sessionID blockArray:^(NSMutableArray *waters, NSError *error, ErrorMessage *errorMessage) {
        
        if (waters) {
            self.modelList = waters;
            [self.KTCarttableView reloadData];
    
        }
        if (error) {
            NSLog(@"--wangluoyichang--");
        }
        if (errorMessage) {
            NSLog(@"--gouwuche-%@",errorMessage.message);
        }
        
    }];
    
    
}



- (IBAction)popVc:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"selected"])
//    {
//        [self sumPrice];
//    }
//    else if ([keyPath isEqualToString:@"count"])
//    {
//        [self sumPrice];
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}
//-(void)sumPrice
//{
//    float sumPrice=0;
//    for (int i=0; i<self.modelList.count; i++) {
//        CartList *model =self.modelList[i];
//        if (model.selected==YES) {
//            sumPrice+=model.price*model.count;
//        }
//    }
//    self.sumPriceLab.text =[NSString stringWithFormat:@"%f",sumPrice];
//}



- (IBAction)payCount:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTInformationConfViewController" bundle:nil];
    KTInformationConfViewController *login2 = [storyboard instantiateInitialViewController];
    //login.waterSending = self.waterSending;
    
    // [self.navigationController pushViewController:login animated:YES];
    

    [self presentViewController:login2 animated:YES completion:nil];
    

}
@end
