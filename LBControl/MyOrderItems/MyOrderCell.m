//
//  MyOrderCell.m
//  民生小区
//
//  Created by 闫青青 on 15/5/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyOrderCell.h"
#import "MyOrderModel.h"
#import "RegisterViewController.h"
@interface MyOrderCell()
//总金额
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//总价
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
//更新时间
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
//订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;



@end
@implementation MyOrderCell

- (void)awakeFromNib {
    // Initialization code
}
//配置cell
- (void)configOrderModelWith:(MyOrderModel *)OrderModel{
    self.totalPrice.text =[[ NSString alloc] initWithFormat:@"%.2f",OrderModel.totalCash];
    //initWithFormat:@"%d",index
    self.totalNum.text = [[ NSString alloc] initWithFormat:@"%d",OrderModel.totalNumbers];
    self.updateTime.text = [[ NSString alloc] initWithFormat:@"%@",OrderModel.updateTime];
    self.orderNumber.text = OrderModel.orderNumber;
    NSLog(@"%@---%@---时间%@--编号:%@",self.totalPrice.text,self.totalNum.text,self.updateTime.text,self.orderNumber.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
