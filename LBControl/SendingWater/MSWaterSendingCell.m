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
#import "MJExtension.h"
#import "TableViewController.h"
#import "KTWaterDetailsViewController.h"

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
    MSWaterSendingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MSWaterSendingCell" owner:nil options:nil] firstObject];
    }
    
//    if (cell == nil) {
//        cell = [[MSWaterSendingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
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
    
    // sdwebIMge
    //    if(model.productUrl == nil) return;
    //    NSURL *url = [NSURL URLWithString:model.productUrl];
    //    [self.mIconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"a9"] options:SDWebImageRetryFailed |SDWebImageLowPriority];
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
//    // 获取跳转到的控制器
//    KTWaterDetailsViewController *detail = [[KTWaterDetailsViewController alloc] init];
//    //控制器传值到下一个控制器, 也就是正向传值
//    detail.waterSending = self.model;
//    // 推出到指定控制器
//    [self.viewController.navigationController pushViewController:detail animated:YES];
  
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    KTWaterDetailsViewController *login2 = [storyboard instantiateInitialViewController];
    login2.waterSending = self.model;
    [self.viewController.navigationController pushViewController:login2 animated:YES];
}




@end
