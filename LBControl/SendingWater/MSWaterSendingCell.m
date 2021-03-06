//
//  MSWaterSendingCell.m
//  民生小区
//
//  Created by Milo. on 15-4-15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MSWaterSendingCell.h"
#import "WaterSending.h"
#import "UIImageView+WebCache.h"
#import "LBSendingWaterTableViewController.h"
#import "KTWaterDetailsViewController.h"
#import "LBControllerHeader.h"

@interface MSWaterSendingCell ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *introduce;

@property (weak, nonatomic) IBOutlet UILabel *unitPrice;

@property (weak, nonatomic) IBOutlet UILabel *preferPrice;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (nonatomic, strong) UIViewController *viewController;

- (IBAction)goBuy:(UIButton *)sender;


@end

@implementation MSWaterSendingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    //从NIB中获取
    MSWaterSendingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MSWaterSendingCell" owner:nil options:nil] firstObject];
    }
    return  cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        [self setupView];
    }
    return self;
}

// 设置模型数据
- (void)setModel:(WaterSending *)model
{
    NSLog(@"%@", model);
    _model = model;
    self.unitPrice.text = [NSString stringWithFormat:@"￥%d", model.unitPrice];
    //简介
    self.introduce.text = model.introduce;
    // 银行卡价格
    self.preferPrice.text  = [NSString stringWithFormat:@"￥%d",model.preferPrice];
    //销售状态
    self.salePrice.text = [NSString stringWithFormat:@"￥%d",model.salePrice];
}



#pragma mark - 懒加载
// 获取view对应的控制器

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        // 获取下一个响应者
        UIResponder* nextResponder = [next nextResponder];
        // 判读是否为控制器，若是则返回即可
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (IBAction)goBuy:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    KTWaterDetailsViewController *shoppControl = [storyboard instantiateViewControllerWithIdentifier:@"KTWaterDetailsViewController"];
        
    shoppControl.waterSending = _model;
    [self checkLogin:shoppControl waterSending:_model];
    
    //
}
-(void)checkLogin:(KTWaterDetailsViewController *)shoppControl
     waterSending:(WaterSending *)waterSending{
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sessionID = [userDefaults objectForKey:@"sessionId"];
    if (sessionID.length == 0) {
        LoginViewController  *nv = [[LoginViewController  alloc]init];
        
        //[self presentViewController:nv animated:YES completion:nil];
        [self.viewController.navigationController
         pushViewController:nv animated:YES] ;
    }else{
        ShoppingCart *shoppingCart =[[ShoppingCart alloc] init];
        shoppingCart.sessionId=sessionID;
        shoppingCart.currentCount=[[NSNumber alloc] initWithLong:0];
        shoppingCart.businessProductId=[[NSNumber alloc]
                                        initWithLong:waterSending.id];
        [self getCard:shoppingCart];
        shoppControl.shoppingCart=shoppingCart;
        
        [self.viewController.navigationController pushViewController:shoppControl animated:YES];
    }
}

-(void) getCard:(ShoppingCart *)shoppingCart

{
    [ShoppingCart addCart:shoppingCart
               blockArray:nil
     ];
    
}
@end
