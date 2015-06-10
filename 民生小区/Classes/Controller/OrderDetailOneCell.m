//
//  OrderDetailOneCell.m
//  民生小区
//
//  Created by 闫青青 on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "OrderDetailOneCell.h"
#import "orderDetailCell.h"
#import "orderDetailOneModel.h"
@interface OrderDetailOneCell()<UITableViewDataSource, UITableViewDelegate>
//商家名称
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
@implementation OrderDetailOneCell

- (void)awakeFromNib {
    // Initialization code
    //    设置数据源和代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"orderDetailCell";
    orderDetailCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"orderDetailCell" owner:nil options:nil];
        cell = cells[0];
        //        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
//配置cell
- (void)configOrderDetailOneModelWith:(orderDetailOneModel*)orderDetailOneModel{
    
    self.businessName.text = orderDetailOneModel.businessName;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
