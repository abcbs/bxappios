//
//  WaitPaymentDetail.m
//  民生小区
//
//  Created by 闫青青 on 15/5/21.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "WaitPaymentDetail.h"
#import "RegistModel.h"
#import "OrderDetailOneCell.h"
#import "Conf.h"
@interface WaitPaymentDetail ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) RegistModel *regist;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation WaitPaymentDetail
@synthesize tableView = _tableView;
@synthesize orderDetailArr = _orderDetailArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    _orderDetailArr = [[NSMutableArray alloc]init];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"ddlb_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
   [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //订单号Label
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 80, 30)];
    detailLabel.text = @"订单号:";
    UILabel *detailNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 65, 150, 30)];
    detailNumLabel.text = @"123443423435566";
    [self.view addSubview:detailLabel];
    [self.view addSubview:detailNumLabel];
    //合计label
    UILabel *amount = [[UILabel alloc]initWithFrame:CGRectMake(30, 520, 50, 30)];
    amount.text = @"合计:";
    UILabel *amountNum = [[UILabel alloc]initWithFrame:CGRectMake(90, 520, 80, 30)];
    amountNum.text = @"521.00";
    [self.view addSubview:amount];
    [self.view addSubview:amountNum];
    //取消订单，立即支付button
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(150, 520, 70, 30)];
    [cancel setBackgroundImage:[UIImage imageNamed:@"qxdd.png"] forState:UIControlStateNormal];
    UIButton *payment = [[UIButton alloc]initWithFrame:CGRectMake(230, 520, 70, 30)];
    [payment setBackgroundImage:[UIImage imageNamed:@"ljzf.png"] forState:UIControlStateNormal];
    [self.view addSubview:cancel];
    [self.view addSubview:payment];
#pragma mark--tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATIONBAR_HEIGHT+50 , SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT-100) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    //滑不到头时改变这个属性
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.sectionHeaderHeight = 1;
    [self.view addSubview:self.tableView];
    _regist = [[RegistModel alloc]init];
//    [_regist orderDetail];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderDetailArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"OrderDetailOneCell";
    OrderDetailOneCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailOneCell" owner:nil options:nil];
        cell = cells[0];
        [cell configOrderDetailOneModelWith:_orderDetailArr[indexPath.row]];
//        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;

}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
//开始下载数据
- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
    _regist = [[RegistModel alloc]init];
    [_regist myOrderDetailWithBlock:^(id obj) {
        self.orderDetailArr = [NSMutableArray arrayWithArray:obj];
        [_tableView reloadData];
    } failed:^(id error) {
        NSLog(@"%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClickeds:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
