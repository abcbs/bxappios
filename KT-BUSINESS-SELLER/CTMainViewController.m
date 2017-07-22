//
//  CTMainViewController.m
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CTMainViewController.h"



@interface CTMainViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *transactionTypeData;
    NSArray *giftRelationshipData;
    NSArray *houseTypeData;//房屋类型
    NSArray *buyerHistTypeData;//买方住房记录类型
    NSArray *sellerHouseTypeData;//卖方住房类型
    NSArray *sellerFixedYearsTypeData;//卖方购房年限类型
    NSArray *sellerHouseRecordTypeData;//卖方购房记录类型
    NSArray *incomeTaxTypeData;//个人所得税征收方式
    NSArray *landTaxTypeData;//土地增值税征收方式
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
    //0-交易类型
    transactionType=0;
    //1-赠与类型
    giftRelationshipType=1;
    //2-房屋类型
    houseType=2;
    //3-买方住房记录类型
    buyerHistType=3;
    //4-卖方住房类型;
    sellerHouseType=4;
    //5-卖方购房年限类型
    sellerFixedYearsType=5;
    //6-卖方购房记录类型
    sellerHouseRecordType=6;
    //7-个人所得税征收方式
    incomeTaxType=7;
    //8-土地增值税征收方式
    landTaxType=8;
    
    //0-交易类型
    transactionTypePick.delegate=self;
    transactionTypePick.dataSource = self;
    transactionTypePick.showsSelectionIndicator=YES;
    transactionTypeData=[[NSArray alloc]initWithObjects:@"",@"买卖",@"赠与", nil];
    
    //1-赠与类型
    giftRelationshipPick.delegate=self;
    giftRelationshipPick.dataSource = self;
    giftRelationshipPick.showsSelectionIndicator=YES;
    giftRelationshipData=[[NSArray alloc]initWithObjects:@"",@"亲属关系",@"非亲属关系", nil];
    
    //2-房屋类型
    houseTypePick.delegate=self;
    houseTypePick.dataSource = self;
    houseTypePick.showsSelectionIndicator=YES;
    houseTypeData=[[NSArray alloc]initWithObjects:@"",@"住房",@"非住房", nil];
   
    //3-买方住房记录类型
    buyerHistTypePick.delegate=self;
    buyerHistTypePick.dataSource = self;
    buyerHistTypePick.showsSelectionIndicator=YES;
    buyerHistTypeData=[[NSArray alloc]initWithObjects:@"",@"家庭唯一住房",@"非家庭唯一住房", nil];
    
    //4-卖方住房类型
    sellerHouseTypePick.delegate=self;
    sellerHouseTypePick.dataSource = self;
    sellerHouseTypePick.showsSelectionIndicator=YES;
    sellerHouseTypeData=[[NSArray alloc]initWithObjects:@"",@"普通住房",@"非普通住房", nil];
    
    //5-卖方购房年限类型
    sellerFixedYearsTypePick.delegate=self;
    sellerFixedYearsTypePick.dataSource = self;
    sellerFixedYearsTypePick.showsSelectionIndicator=YES;
    sellerFixedYearsTypeData=[[NSArray alloc]initWithObjects:@"",@"不满两年",@"满两年不满五年",@"已满五年", nil];
    
    //6-卖方购房记录类型
    sellerHouseRecordTypePick.delegate=self;
    sellerHouseRecordTypePick.dataSource = self;
    sellerHouseRecordTypePick.showsSelectionIndicator=YES;
    sellerHouseRecordTypeData=[[NSArray alloc]initWithObjects:@"",@"家庭唯一住房",@"非家庭唯一住房", nil];
    
    //7-个人所得税征收方式
    incomeTaxTypePick.delegate=self;
    incomeTaxTypePick.dataSource = self;
    incomeTaxTypePick.showsSelectionIndicator=YES;
    incomeTaxTypeData=[[NSArray alloc]initWithObjects:@"",@"核定征收",@"据实征收", @"满五年家庭唯一住房免税",nil];
    
    //8-土地增值税征收方式
    landTaxTypePick.delegate=self;
    landTaxTypePick.dataSource = self;
    landTaxTypePick.showsSelectionIndicator=YES;
    landTaxTypeData=[[NSArray alloc]initWithObjects:@"",@"核定征收",@"据实征收", @"个人住房免税",nil];
    
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
    
    //逻辑控制与说明
    //个人所得税
    incomeTaxTypeFactsContent=@"据实征收";
    //土地增值税征收方式
    landTaxTypeFactsContent=@"据实征收";
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
    NSLog(@"TAG=%d",pickerView.tag);
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
    [lbl setTextAlignment:0];
    if(row==0){
        [lbl setBackgroundColor: [UIColor redColor]];
    }else{
        [lbl setBackgroundColor: [UIColor lightGrayColor]];
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
    if(pickerView.tag == transactionType && row==2){
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
#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    NSLog(@"prepareForSegue");

}


@end
