//
//  orderDetailCell.m
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "orderDetailCell.h"
#import "orderDetailModel.h"
@interface orderDetailCell()
//商品简介
@property (weak, nonatomic) IBOutlet UILabel *goodIntroduce;
//商品单价
@property (weak, nonatomic) IBOutlet UILabel *salesPrice;
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *numbers;
//商品总价
@property (weak, nonatomic) IBOutlet UILabel *total;


@end
@implementation orderDetailCell

- (void)awakeFromNib {
    // Initialization code
}
//配置cell
- (void)configOrderDetailTwoModelWith:(orderDetailModel*)orderDetailTwoModel{
    self.goodIntroduce.text = orderDetailTwoModel.goodIntroduce;
    self.salesPrice.text = [[ NSString alloc] initWithFormat:@"%.2f",orderDetailTwoModel.salesPrice];
    self.numbers.text = [[NSString alloc]initWithFormat:@"%d",orderDetailTwoModel.numbers];
    self.total.text = [[ NSString alloc] initWithFormat:@"%.2f",orderDetailTwoModel.total];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
