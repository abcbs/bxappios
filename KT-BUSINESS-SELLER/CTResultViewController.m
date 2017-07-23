//
//  CTResultViewController.m
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CTResultViewController.h"

@implementation CTResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BSUIComponentView configButtonStyle:self.builtResultToTextsButton];
  
    NSString * device=[Conf deviceMachine];
    if([device isEqualToString:@"iPhone 4S"]){
        self.contractTaxRateSellerLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxRateSellerTotalLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxRateNodeSellerLabel.font = [UIFont systemFontOfSize:14];
        self.contractTaxSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutyRateSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutyRateNoteSellerLabel.font = [UIFont systemFontOfSize:14];
        self.stampDutySellerLabel.font = [UIFont systemFontOfSize:14];
        
        self.stampDutyRateNoteSellerLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerNoteLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerLabel.font = [UIFont systemFontOfSize:14];
        
        
        self.stampDutySellerNoteLabel.font = [UIFont systemFontOfSize:14];
        
        self.stampDutySellerLabel.font = [UIFont systemFontOfSize:14];

        
        self.stampDutyRateSellerTotalLabel.font = [UIFont systemFontOfSize:14];
        
        self.addedValueTaxRateTotalBuyerLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxRateBuyerNoteLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxRateBuyerLabel.font = [UIFont systemFontOfSize:14];
        
        self.addedValueTaxNoteBuyerLabel.font = [UIFont systemFontOfSize:14];

        
        self.addedValueTaxBuyerLabel.font = [UIFont systemFontOfSize:14];

    }
    //买方信息-契税
    self.contractTaxRateSellerLabel.text=[CTTxtInfo
                                          convertFloatToStringProc:self.taxInfo.contractTaxRateSeller];
    self.contractTaxSellerLabel.text=[CTTxtInfo
                                       convertFloatToString:self.taxInfo.contractTaxSeller];
    //买方信息-印花税
    self.stampDutyRateSellerLabel.text=[CTTxtInfo
                                  convertFloatToStringProc:self.taxInfo.stampDutyRateSeller];

    self.stampDutySellerLabel.text=[CTTxtInfo
                              convertFloatToString:self.taxInfo.stampDutySeller];
    //卖方信息
    //卖方信息-增值税率
    self.addedValueTaxRateBuyerLabel.text=[CTTxtInfo
                                            convertFloatToStringProc:self.taxInfo.addedValueTaxRateBuyer];

    
    self.addedValueTaxBuyerLabel.text=[CTTxtInfo
                                       convertFloatToString:self.taxInfo.addedValueTaxBuyer];;
    
    //卖方信息-城建税
    self.cityTaxRateBuyerLabel.text=[CTTxtInfo
                                     convertFloatToStringProc:self.taxInfo.cityTaxRateBuyer];
    
    
    self.cityTaxBuyerLabel.text=[CTTxtInfo
                                 convertFloatToString:self.taxInfo.cityTaxBuyer];
    
    
    //卖方信息-教育税率
    self.eduTaxRateBuyerLabel.text=[CTTxtInfo
                                    convertFloatToStringProc:self.taxInfo.eduTaxRateBuyer];
    
    
    self.eduTaxBuyerLabel.text=[CTTxtInfo
                                convertFloatToString:self.taxInfo.eduTaxBuyer];
    
    //卖方信息-地方教育税率
    
    self.localEduTaxRateBuyerLabel.text=[CTTxtInfo
                                         convertFloatToStringProc:self.taxInfo.localEduTaxRateBuyer];
    
    self.localEduTaxBuyerLabel.text=[CTTxtInfo
                                     convertFloatToString:self.taxInfo.localEduTaxBuyer];
    
    //卖方信息-印花税
    self.stampDutyRateBuyerLabel.text=[CTTxtInfo
                                       convertFloatToStringProc:self.taxInfo.stampDutyRateBuyer];
    
    
    self.stampDutyBuyerLabel.text=[CTTxtInfo
                                   convertFloatToString:self.taxInfo.stampDutyBuyer];
    
    //卖方信息-土地增值税
    
    self.addedLandRateBuyerLabel.text=[CTTxtInfo
                                       convertFloatToStringProc:self.taxInfo.addedLandRateBuyer];

    
    self.addedLandBuyerLabel.text=[CTTxtInfo
                                   convertFloatToString:self.taxInfo.addedLandBuyer];
    
    //卖方信息-个人所得税
    self.incomeRateBuyerLabel.text=[CTTxtInfo
                                    convertFloatToStringProc:self.taxInfo.incomeRateBuyer];


    self.incomeLandBuyerLabel.text=[CTTxtInfo
                                    convertFloatToString:self.taxInfo.incomeLandBuyer];
    
    //
    self.calDateLabel.text=[self currentDate];
    
    //按钮响应点击事件，最常用的方法：第一个参数是目标对象，一般都是self； 第二个参数是一个SEL类型的方法；第三个参数是按钮点击事件
    [self.builtResultToTextsButton addTarget:self action:@selector(builtResultToTexts) forControlEvents:UIControlEventTouchUpInside];
    
}

//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *titleHeader=[super tableView:tableView
//                   titleForHeaderInSection:section];
//    if(section==2){
//        titleHeader=[NSString stringWithFormat:@"计算日期%@",
//                     [self currentDate] ];
//    }
//    return titleHeader;
//}

//先执行titleForHeaderInSection
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* viewHeader=[super tableView:tableView
//                 viewForHeaderInSection:section];
//    NSString *titleHeader=[super tableView:tableView
//                   titleForHeaderInSection:section];
//    //日期栏
//    if(section==2){
//        UIView *catagoryView=[UIView new];
//        
//        //添加到视图
//        NSString* dataHeader=[NSString stringWithFormat:@"                    计算日期%@",
//                     [self currentDate] ];
//        [catagoryView addSubview:[self headerLable:dataHeader rect:BSRectMake(8, -6, 360, 44)]];
//        
//        viewHeader=catagoryView;
//        
//    
//    }
//    return viewHeader;
//}

-(UILabel *)headerLable:(NSString *)title rect:(CGRect)rect{
    UILabel *headLable=[[UILabel alloc]init];
    headLable.text=title;
    headLable.frame =rect;//
    headLable.textAlignment = NSTextAlignmentRight;
    [headLable sizeToFit];
    return headLable;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *titleFooter=[super tableView:tableView
                   titleForFooterInSection:section];
    if(section==0){
        titleFooter=[NSString stringWithFormat:@"买方（转入方）各项应纳税款总计%.2f元",
                     self.taxInfo.totalSeller];
    }
    if(section==1){
        titleFooter=[NSString stringWithFormat:@"卖方（转出方）各项应纳税款总计%.2f元",
                     self.taxInfo.totalBuyer];
    }
    
    return titleFooter;
}

- (IBAction)builtResultToTexts:(id)sender {
    [self builtResultToTexts];
}
//针对于响应方法的实现
-(void)builtResultToTexts
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = [self.taxInfo formattedTaxResult];
}
- (NSString *)currentDate
{
    
    return [CTTxtInfo currentDate];
}

@end
