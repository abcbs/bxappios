//
//  CTMainViewController.m
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//
#import "CTMainViewController.h"
#import "CTTxtInfo.h"
#import "CTResultViewController.h"
#import "PromptInfo.h"
#import "BSIFTTHeader.h"
@interface CTMainViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,
        UITextFieldDelegate,UITextViewDelegate>

{
    NSArray *transactionTypeData;//0-交易类型
    NSArray *giftRelationshipData;//1-赠与关系
    NSArray *houseTypeData;//2-房屋类型
    NSArray *buyerHistTypeData;//3-买方住房记录类型
    NSArray *sellerHouseTypeData;//4-卖方住房类型
    NSArray *sellerFixedYearsTypeData;//5-卖方购房年限类型
    NSArray *sellerHouseRecordTypeData;//6-卖方购房记录类型
    NSArray *incomeTaxTypeData;//7-个人所得税征收方式
    NSArray *landTaxTypeData;//8-土地增值税征收方式
    NSMutableArray *pickArr;
    
    //0-交易类型
    NSInteger transactionType;
    //1-赠与类型
    NSInteger giftRelationshipType;
    //2-房屋类型
    NSInteger houseType;
    //3-买方住房记录类型
    NSInteger buyerHistType;
    //4-卖方住房类型;
    NSInteger sellerHouseType;
    //5-卖方购房年限类型
    NSInteger sellerFixedYearsType;
    //6-卖方购房记录类型
    NSInteger sellerHouseRecordType;
    //7-个人所得税征收方式
    NSInteger incomeTaxType;
    //8-土地增值税征收方式
    NSInteger landTaxType;
    
    //个人所得税方式，如果是据实征收的逻辑
    NSString *incomeTaxTypeFacts;
    NSString *incomeTaxTypeFactsContent;
    
    //土地增值税征收方式，如果是据实征收的逻辑
    NSString *landTaxTypeFacts;
    NSString *landTaxTypeFactsContent;
    
    CTTxtInfo *calTaxInfo;
}



@end

@implementation CTMainViewController
@synthesize transactionTypePick;
@synthesize giftRelationshipPick;
@synthesize giftRelationshipLabel;
@synthesize houseTypePick;
@synthesize buyerHistTypePick;
@synthesize sellerHouseTypePick;
@synthesize sellerFixedYearsTypePick;
@synthesize sellerHouseRecordTypePick;
@synthesize incomeTaxTypePick;
@synthesize landTaxTypePick;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    calTaxInfo=[CTTxtInfo calTaxInfo];
    //0-交易类型
    transactionType=[CTTxtInfo transactionType];
    //1-赠与类型
    giftRelationshipType=[CTTxtInfo giftRelationshipType];
    //2-房屋类型
    houseType=[CTTxtInfo houseType];
    //3-买方住房记录类型
    buyerHistType=[CTTxtInfo buyerHistType];
    //4-卖方住房类型;
    sellerHouseType=[CTTxtInfo sellerHouseType];
    //5-卖方购房年限类型
    sellerFixedYearsType=[CTTxtInfo sellerFixedYearsType];
    //6-卖方购房记录类型
    sellerHouseRecordType=[CTTxtInfo sellerHouseRecordType];
    //7-个人所得税征收方式
    incomeTaxType=[CTTxtInfo incomeTaxType];
    //8-土地增值税征收方式
    landTaxType=[CTTxtInfo landTaxType];
    
    //逻辑控制与说明
    //个人所得税
    incomeTaxTypeFactsContent=[CTTxtInfo incomeTaxTypeFactsContent];
    //土地增值税征收方式
    landTaxTypeFactsContent=[CTTxtInfo landTaxTypeFactsContent];

    
    //0-交易类型
    transactionTypePick.delegate=self;
    transactionTypePick.dataSource = self;
    transactionTypePick.showsSelectionIndicator=YES;
    transactionTypeData=[CTTxtInfo transactionTypeData];
    
    //1-赠与类型
    giftRelationshipPick.delegate=self;
    giftRelationshipPick.dataSource = self;
    giftRelationshipPick.showsSelectionIndicator=YES;
    giftRelationshipData=[CTTxtInfo giftRelationshipData];
    
    //2-房屋类型
    houseTypePick.delegate=self;
    houseTypePick.dataSource = self;
    houseTypePick.showsSelectionIndicator=YES;
    houseTypeData=[CTTxtInfo houseTypeData];

    
    //3-买方住房记录类型
    buyerHistTypePick.delegate=self;
    buyerHistTypePick.dataSource = self;
    buyerHistTypePick.showsSelectionIndicator=YES;
    buyerHistTypeData=[CTTxtInfo buyerHistTypeData];
    
    //4-卖方住房类型
    sellerHouseTypePick.delegate=self;
    sellerHouseTypePick.dataSource = self;
    sellerHouseTypePick.showsSelectionIndicator=YES;
    sellerHouseTypeData=[CTTxtInfo sellerHouseTypeData];
    
    //5-卖方购房年限类型
    sellerFixedYearsTypePick.delegate=self;
    sellerFixedYearsTypePick.dataSource = self;
    sellerFixedYearsTypePick.showsSelectionIndicator=YES;
    sellerFixedYearsTypeData=[CTTxtInfo sellerFixedYearsTypeData];
    
    //6-卖方购房记录类型
    sellerHouseRecordTypePick.delegate=self;
    sellerHouseRecordTypePick.dataSource = self;
    sellerHouseRecordTypePick.showsSelectionIndicator=YES;
    sellerHouseRecordTypeData=[CTTxtInfo sellerHouseRecordTypeData];
    
    //7-个人所得税征收方式
    incomeTaxTypePick.delegate=self;
    incomeTaxTypePick.dataSource = self;
    incomeTaxTypePick.showsSelectionIndicator=YES;
    incomeTaxTypeData=[CTTxtInfo incomeTaxTypeData];
    
    //8-土地增值税征收方式
    landTaxTypePick.delegate=self;
    landTaxTypePick.dataSource = self;
    landTaxTypePick.showsSelectionIndicator=YES;
    landTaxTypeData=[CTTxtInfo landTaxTypeData];
    
    //样式控制
    [BSUIComponentView configTextField:self.builtAreaTextField];
    [BSUIComponentView configTextField:self.onlineSignedPriceTextField];
    [BSUIComponentView configTextField:self.approvedPriceTextField];
    [BSUIComponentView configTextField:self.houseRawPriceTextField];

    [BSUIComponentView configTextField:self.houseRawPriceTextField];
    [BSUIComponentView configTextField:self.contractRawTaxTextField];
    [BSUIComponentView configTextField:self.renovationFaxTextField];
    [BSUIComponentView configTextField:self.loanInterestTextField];
    
    [BSUIComponentView configTextField:self.houseRawPriceLandTextField];
    [BSUIComponentView configTextField:self.contractRawTaxLandTextField];
    [BSUIComponentView configTextField:self.invoicesYearLimitTextField];


    //选项数据
    pickArr=[[NSMutableArray alloc] init];
    [pickArr addObject:transactionTypeData];//0
    [pickArr addObject:giftRelationshipData];//1
    [pickArr addObject:houseTypeData];//2
    [pickArr addObject:buyerHistTypeData];//3
    [pickArr addObject:sellerHouseTypeData];//4
    [pickArr addObject:sellerFixedYearsTypeData];//5
    [pickArr addObject:sellerHouseRecordTypeData];//6
    [pickArr addObject:incomeTaxTypeData];//7
    [pickArr addObject:landTaxTypeData];//8
    
   }


#pragma mark Picker Date Source Methods

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //0-交易类型                transactionType=0;
    //1-赠与类型                giftRelationshipType=1;
    //2-房屋类型                houseType=2;
    //3-买方住房记录类型          buyerHistType=3;
    //4-卖方住房类型;            sellerHouseType=4;
    //5-卖方购房年限类型          sellerFixedYearsType=5;
    //6-卖方购房记录类型          sellerHouseRecordType=6;
    //7-个人所得税征收方式         incomeTaxType=7;
    //8-土地增值税征收方式         landTaxType=8;

    
    if(pickerView.tag == transactionType){
        return [transactionTypeData count];
    }
    if(pickerView.tag == giftRelationshipType){
        return [giftRelationshipData count];
    }
    if(pickerView.tag == houseType){
        return [houseTypeData count];
    }
    if(pickerView.tag == buyerHistType){
        return [buyerHistTypeData count];
    }
    if(pickerView.tag == sellerHouseType){
        return [sellerHouseTypeData count];
    }
    if(pickerView.tag == sellerFixedYearsType){
        return [sellerFixedYearsTypeData count];
    }
    if(pickerView.tag == sellerHouseRecordType){
        return [sellerHouseRecordTypeData count];
    }
    if(pickerView.tag == incomeTaxType){
        return [incomeTaxTypeData count];
    }
    if(pickerView.tag == landTaxType){
        return [landTaxTypeData count];
    }
    NSInteger  currentRow=[pickerView selectedRowInComponent:component];
    return [pickArr[currentRow] count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSInteger  currentRow=pickerView.tag;

    return pickArr[currentRow][row];
}

//UIPickerView 行的大小和字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc]init];
    }
    lbl.font =  [UIFont systemFontOfSize:17];
//    [BSUIComponentView configLableStyle:lbl];

    [lbl setTextAlignment:0];
    if(row==0){//configLableStyle
        [lbl setBackgroundColor: [UIColor lightGrayColor]];
    }else{
        [lbl setBackgroundColor: [UIColor whiteColor]];
    }
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    //如果交易类型为赠与，则显示【赠与关系】，再次选择时重置【赠与关系】显示数据
    if(pickerView.tag == transactionType && row==2){
        [giftRelationshipPick selectRow:0 inComponent:0 animated:YES];
    }
    return lbl;
}

//选择完成之后的事件:
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen
{
    
    //[pickerView reloadComponent:1];
    //如果交易类型为赠与，则显示【赠与关系】
    //0-交易类型            transactionType=0;
    //1-赠与类型            giftRelationshipType=1;
    //2-房屋类型            houseType=2;
    //3-买方住房记录类型     buyerHistType=3;
    //4-卖方住房类型        sellerHouseType=4;
    //5-卖方购房年限类型     sellerFixedYearsType=5;
    //6-卖方购房记录类型     sellerHouseRecordType=6;
    //7-个人所得税征收方式   incomeTaxType=7;
    //8-土地增值税征收方式   landTaxType=8;
    
    //如果交易类型为赠与，则显示【赠与关系】
    if(pickerView.tag == transactionType && row==2){//第二个选项
        giftRelationshipPick.hidden=NO;
        giftRelationshipLabel.hidden=NO;
        
    }else if(pickerView.tag == transactionType){
        giftRelationshipPick.hidden=YES;
        giftRelationshipLabel.hidden=YES;
       
    }
    //选择个人所得税征收方式为据实征收时，记录其内容，并触发表格刷新
    if(pickerView.tag == incomeTaxType && row==2){
        incomeTaxTypeFacts=incomeTaxTypeFactsContent;
        [self.tableView reloadData];
    }else if(pickerView.tag == incomeTaxType && row!=2){
        incomeTaxTypeFacts=@"";
        [self.tableView reloadData];
    }
    //土地增值税征收方式
    if(pickerView.tag == landTaxType && row==2){
        landTaxTypeFacts=landTaxTypeFactsContent;
        [self.tableView reloadData];
    }else if(pickerView.tag == landTaxType && row!=2){
        landTaxTypeFacts=@"";
        [self.tableView reloadData];
    }
    
    //
    //0-交易类型            transactionType=0;
    if(pickerView.tag == transactionType){
        calTaxInfo.transactionTypeCurrent=transactionTypeData[row];
    }
    //1-赠与类型            giftRelationshipType=1;
    if(pickerView.tag == giftRelationshipType){
        calTaxInfo.giftRelationshipCurrent=giftRelationshipData[row];
    }
    //2-房屋类型            houseType=2;
    if(pickerView.tag == houseType){
        calTaxInfo.houseTypeCurrent=houseTypeData[row];
    }
    //3-买方住房记录类型     buyerHistType=3;
    if(pickerView.tag == buyerHistType){
        calTaxInfo.buyerHistTypeCurrent=buyerHistTypeData[row];
    }
    //4-卖方住房类型        sellerHouseType=4;
    if(pickerView.tag == sellerHouseType){
        calTaxInfo.sellerHouseTypeCurrent=sellerHouseTypeData[row];
    }
    //5-卖方购房年限类型     sellerFixedYearsType=5;
    if(pickerView.tag == sellerFixedYearsType){
        calTaxInfo.sellerFixedYearsTypeCurrent=sellerFixedYearsTypeData[row];
    }
    //6-卖方购房记录类型     sellerHouseRecordType=6;
    if(pickerView.tag == sellerHouseRecordType){
        calTaxInfo.sellerHouseRecordTypeCurrent=sellerHouseRecordTypeData[row];
    }
    //7-个人所得税征收方式   incomeTaxType=7;
    if(pickerView.tag == incomeTaxType){
        calTaxInfo.incomeTaxTypeCurrent=incomeTaxTypeData[row];
    }
    //8-土地增值税征收方式   landTaxType=8;
    if(pickerView.tag == landTaxType){
        calTaxInfo.landTaxTypeCurrent=landTaxTypeData[row];
    }
    //
//    [self compareOnlineSignedAndApprovedPrice];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Picker Over

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger idx= indexPath.row;
    //个人所得税征收方式
    if(incomeTaxTypeFacts==incomeTaxTypeFactsContent&&idx==8){
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }else if(incomeTaxTypeFacts!=incomeTaxTypeFactsContent&&idx==8){
        return 0;
    }
    //土地增值税征收方式
    if(landTaxTypeFacts==landTaxTypeFactsContent&&idx==10){
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }else if(landTaxTypeFacts!=landTaxTypeFactsContent&&idx==10){
        return 0;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];;
}

#pragma mark -TableView Start
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=nil;
    NSInteger idx= indexPath.row;
    BSLog(@"indexPath:\t%@",indexPath);
    //联系人信息
    static NSString *ContactCellIdentifier = @"incomeTaxTypeContentCell";
    cell  = [self obtainCellWith:ContactCellIdentifier];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ContactCellIdentifier];
    //个人所得税征收方式为据实征收时
    if(incomeTaxTypeFacts==incomeTaxTypeFactsContent&&idx==8){
        cell.hidden=NO;
    }else if(idx==8){
        cell.hidden=YES;
        return cell;
    }
    
    UITableViewCell* landTaxCell=nil;
    
    //土地增值税征收方式
    static NSString *landTaxContactCellIdentifier = @"landTaxTypeContentCell";
    landTaxCell  = [self obtainCellWith:landTaxContactCellIdentifier];
    landTaxCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:landTaxContactCellIdentifier];
    
    if(landTaxTypeFacts == landTaxTypeFactsContent && idx==10){
         landTaxCell.hidden=NO;
    }else if(idx==10){
        landTaxCell.hidden=YES;
        return landTaxCell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleHeader=[super tableView:tableView
                   titleForHeaderInSection:section];
 
    return titleHeader;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *titleFooter=[super tableView:tableView
                   titleForFooterInSection:section];
    
    return titleFooter;
}

#pragma mark -TableView Over

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘
-(void)delelageForTextField{
    //网签价格
    self.onlineSignedPriceTextField.delegate=self;
    //核定价格
    self.approvedPriceTextField.delegate=self;
    //建筑面积
    self.builtAreaTextField.delegate=self;
    //房屋原始价格
    self.houseRawPriceTextField.delegate=self;
     //房屋原始契税
    self.contractRawTaxTextField.delegate=self;
    //装修费用
    self.renovationFaxTextField.delegate=self;
    //贷款利息
    self.loanInterestTextField.delegate=self;
    //房屋原始价格-土地增值税
    self.houseRawPriceLandTextField.delegate=self;
    //房屋原始契税-土地增值税
    self.contractRawTaxLandTextField.delegate=self;
    //发票年限
    self.invoicesYearLimitTextField.delegate=self;
    

}

//每次键盘输入值均变化
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self compareOnlineSignedAndApprovedPrice];
//    NSString *number=textField.text;
//    BOOL is=[BSValidatePredicate checkNumber:number];
//    if(is==NO){
//        [PromptInfo showWithText:@"数字应为包含两位小数的数字" topOffset:54 duration:2];
//    }

    return YES;
    
}

/** Finishes the editing */
- (void)dismissKeyboard
{
    [self compareOnlineSignedAndApprovedPrice];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    BOOL is=[BSValidatePredicate checkNumber:textField.text];
//    if(is==NO){
//        [PromptInfo showWithText:@"数字应为包含两位小数的数字" topOffset:54 duration:2];
//    }
    [self compareOnlineSignedAndApprovedPrice];
    return YES;
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"calTaxSegue"])
    {
        CTResultViewController *info = (CTResultViewController *)segue.destinationViewController;
        info.resultDelegate=self;
        [calTaxInfo calTax];//计算步骤
        info.taxInfo=calTaxInfo;
    }


}

#pragma mark - 比较网签与核定价格大小
//
//网签价格
- (void)compareOnlineSignedAndApprovedPrice
{
    float onlineSignedPrice=[CTTxtInfo convertStringToFloat:self.onlineSignedPriceTextField.text];
    //核定价格
    float approvedPrice=[CTTxtInfo convertStringToFloat:self.approvedPriceTextField.text];
    if(approvedPrice==0&&onlineSignedPrice==0){
        self.onlineSignedPriceTextField.backgroundColor=[UIColor whiteColor];
        self.approvedPriceTextField.backgroundColor=[UIColor whiteColor];
        return;
    }
    if(onlineSignedPrice<approvedPrice){
        //self.approvedPriceTextField.backgroundColor=[UIColor lightGrayColor];
        self.approvedPriceTextField.textColor=[UIColor redColor];
        self.onlineSignedPriceTextField.textColor=[UIColor blackColor];
        self.onlineSignedPriceTextField.backgroundColor=[UIColor whiteColor];
        
    }else{
        self.approvedPriceTextField.backgroundColor=[UIColor whiteColor];
        self.onlineSignedPriceTextField.textColor=[UIColor redColor];
        self.approvedPriceTextField.textColor=[UIColor blackColor];
        //self.onlineSignedPriceTextField.backgroundColor=[UIColor lightGrayColor];
    }
    
}

#pragma mark - checkTextField
-(BOOL)checkTextField{
    //下面三个为三个通用输入项
    //房屋建筑面积
    NSString *houseBuiltArea=self.builtAreaTextField.text;
    //网签价格
    NSString *onlineSignedPrice=self.onlineSignedPriceTextField.text;
    //核定价格
    NSString *approvedPrice=self.approvedPriceTextField.text;
    
    //下面为条件控制项
    //房屋原始价格
    NSString *houseRawPrice=self.houseRawPriceTextField.text;
    //房屋原始契税
    NSString *contractRawTax=self.contractRawTaxTextField.text;
    //装修费用
    NSString *renovationFax=self.renovationFaxTextField.text;
    //贷款利息
    NSString *loanInterest=self.loanInterestTextField.text;
    
    
    //房屋原始价格-土地增值税
    NSString *houseRawPriceLand=self.houseRawPriceLandTextField.text;
    //房屋原始契税-土地增值税
    NSString *contractRawTaxLand=self.contractRawTaxTextField.text;
    //发票年限
    NSString *invoicesYearLimit=self.invoicesYearLimitTextField.text;
    
    if([houseBuiltArea isEqualToString:@""]||[onlineSignedPrice isEqualToString:@""]||[approvedPrice isEqualToString:@""]){
       
        if([houseBuiltArea isEqualToString:@""]){

            [PromptInfo showWithText:@"房屋建筑面积不能为空" topOffset:54 duration:2];
        }
        if([onlineSignedPrice isEqualToString:@""]){
            [PromptInfo showWithText:@"网签价格不能为空" topOffset:54 duration:2];
        }
        if([approvedPrice isEqualToString:@""]){
            [PromptInfo showWithText:@"核定价格不能为空" topOffset:54 duration:2];
        }
        return NO;
    }else{
        //
        calTaxInfo.houseBuiltArea=[CTTxtInfo convertStringToFloat:houseBuiltArea];
        calTaxInfo.onlineSignedPrice=[CTTxtInfo convertStringToFloat:onlineSignedPrice];
        calTaxInfo.approvedPrice=[CTTxtInfo convertStringToFloat:approvedPrice];
    }
   
    //0-交易类型            transactionType=0;
    if(calTaxInfo.transactionTypeCurrent==nil ||[calTaxInfo.transactionTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"交易类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //1-赠与类型            giftRelationshipType=1;
    //赠与选项验证
    if([calTaxInfo.transactionTypeCurrent isEqualToString:[CTTxtInfo transactionTypeContent]]
       &&(calTaxInfo.giftRelationshipCurrent==nil ||[calTaxInfo.giftRelationshipCurrent isEqualToString:@""])
       ){
        [PromptInfo showWithText:@"赠与类型不能为空" topOffset:54 duration:2];
      
        return NO;
    }
    //2-房屋类型            houseType=2;
    if(calTaxInfo.houseTypeCurrent==nil ||[calTaxInfo.houseTypeCurrent isEqualToString:@""]){
       [PromptInfo showWithText:@"房屋类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //3-买方住房记录类型     buyerHistType=3;
    if(calTaxInfo.buyerHistTypeCurrent==nil ||[calTaxInfo.buyerHistTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"买方住房记录类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //4-卖方住房类型        sellerHouseType=4;
    if(calTaxInfo.sellerHouseTypeCurrent==nil ||[calTaxInfo.sellerHouseTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"卖方住房类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //5-卖方购房年限类型     sellerFixedYearsType=5;
    if(calTaxInfo.sellerFixedYearsTypeCurrent==nil ||[calTaxInfo.sellerFixedYearsTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"卖方购房年限类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //6-卖方购房记录类型     sellerHouseRecordType=6;
    if(calTaxInfo.sellerHouseRecordTypeCurrent==nil ||[calTaxInfo.sellerHouseRecordTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"卖方购房记录类型不能为空" topOffset:54 duration:2];
        return NO;
    }
    //7-个人所得税征收方式   incomeTaxType=7;
    if(calTaxInfo.incomeTaxTypeCurrent==nil ||[calTaxInfo.incomeTaxTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"个人所得税征收方式不能为空" topOffset:54 duration:2];
        return NO;
    }

    //8-土地增值税征收方式   landTaxType=8;
    if(calTaxInfo.landTaxTypeCurrent==nil ||[calTaxInfo.landTaxTypeCurrent isEqualToString:@""]){
        [PromptInfo showWithText:@"土地增值税征收方式不能为空" topOffset:54 duration:2];
        return NO;
    }
    //个人所得税征收方式为据实征收选项
    if([calTaxInfo.incomeTaxTypeCurrent isEqualToString:[CTTxtInfo incomeTaxTypeFactsContent]]){
        if([houseRawPrice isEqualToString:@""]||[contractRawTax isEqualToString:@""]||[renovationFax isEqualToString:@""]||[loanInterest isEqualToString:@""]){
            if([houseRawPrice isEqualToString:@""]){
                [PromptInfo showWithText:@"房屋原始价格不能为空" topOffset:54 duration:2];
            }
            if([contractRawTax isEqualToString:@""]){
                [PromptInfo showWithText:@"房屋原始契税不能为空" topOffset:54 duration:2];
            }
            if([renovationFax isEqualToString:@""]){
                [PromptInfo showWithText:@"装修费用不能为空" topOffset:54 duration:2];
            }
            if([loanInterest isEqualToString:@""]){
                [PromptInfo showWithText:@"贷款利息不能为空" topOffset:54 duration:2];
            }
            
            return NO;
        }else{
            calTaxInfo.houseRawPrice=[CTTxtInfo convertStringToFloat:houseRawPrice];
            calTaxInfo.contractRawTax=[CTTxtInfo convertStringToFloat:contractRawTax];
            calTaxInfo.renovationFax=[CTTxtInfo convertStringToFloat:renovationFax];
            calTaxInfo.loanInterest=[CTTxtInfo convertStringToFloat:loanInterest];

        }
        
    }
    //土地增值税征收方式，如果是据实征收
    if([calTaxInfo.landTaxTypeCurrent isEqualToString:[CTTxtInfo landTaxTypeFactsContent]]){
        if([houseRawPriceLand isEqualToString:@""]||[contractRawTaxLand isEqualToString:@""]||[invoicesYearLimit isEqualToString:@""]){
            if([houseRawPriceLand isEqualToString:@""]){
                [PromptInfo showWithText:@"房屋原始价格不能为空" topOffset:54 duration:2];
            }
            if([contractRawTaxLand isEqualToString:@""]){
                [PromptInfo showWithText:@"房屋原始契税不能为空" topOffset:54 duration:2];
            }
            if([invoicesYearLimit isEqualToString:@""]){
                [PromptInfo showWithText:@"发票年限不能为空" topOffset:54 duration:2];
            }
            return NO;
        }else{
            calTaxInfo.houseRawPriceLand=[CTTxtInfo convertStringToFloat:houseRawPriceLand];
            calTaxInfo.contractRawTaxLand=[CTTxtInfo convertStringToFloat:contractRawTaxLand];
            calTaxInfo.invoicesYearLimit=[CTTxtInfo convertStringToFloat:invoicesYearLimit];
        }

    }
    return YES;
}

#pragma mark --控制是否可以根据故事板跳转
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL input=[self checkTextField];
    if (input==NO) {
        //[PromptInfo showWithText:@"录入信息不全" topOffset:54 duration:2];
        return NO;
    }else{
        return YES;
    }
    
}


-(CTTxtInfo *) loadTaxInfo:(CTTxtInfo *)taxInfo{
    return calTaxInfo;
}

@end
