//
//  WaitPayment.m
//  民生小区
//
//  Created by 闫青青 on 15/5/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "WaitPayment.h"
#import "Conf.h"
#import "MyOrderCell.h"
#import "AFNHelp.h"
#import "MyOrderModel.h"
#import "RegistModel.h"
#import "WaitPaymentDetail.h"
@interface WaitPayment ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) RegistModel *regist;
@end

@implementation WaitPayment
@synthesize tableView = _tableView;
@synthesize orderArr = _orderArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    _orderArr = [[NSMutableArray alloc]init];
#pragma mark--tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATIONBAR_HEIGHT-81 , SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置每个section之间的间隙
    // self.tableView.sectionHeaderHeight = 1;
    [self.view addSubview:self.tableView];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _orderArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"MyOrderCell";
    MyOrderCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:nil options:nil];
        cell = cells[0];
        [cell configOrderModelWith:_orderArr[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaitPaymentDetail *detail = [[WaitPaymentDetail alloc]init];
    [self presentViewController:detail animated:NO completion:nil];
}
//开始下载数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _regist = [[RegistModel alloc]init];
    [_regist myOrderWithBlock:^(id obj) {
        self.orderArr = [NSMutableArray arrayWithArray:obj];
        [_tableView reloadData];
    } failed:^(id error) {
        NSLog(@"%@",error);
    }];
    
    
}
- (void)didGetData:(NSNotification *)noti{
    NSDictionary *dic = noti.object;
    NSString *isSuccess = dic[@"success"];
    if([isSuccess isEqualToString:@"YES"]){
        [self.orderArr addObjectsFromArray:dic[@"object"]];
    }
    else{
        
        NSString *errMessage = dic[@"object"];
        KT_AlertView_(errMessage);
    }
}


@end
