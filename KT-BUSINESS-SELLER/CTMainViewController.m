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
}



@end

@implementation CTMainViewController
@synthesize transactionTypePick;
@synthesize giftRelationshipPick;
@synthesize houseTypePick;
@synthesize buyerHistTypePick;
@synthesize sellerHouseTypePick;
@synthesize sellerFixedYearsTypePick;
@synthesize sellerHouseRecordTypePick;
@synthesize incomeTaxTypePick;
@synthesize landTaxTypePick;


- (void)viewDidLoad {
    [super viewDidLoad];
    //交易类型
    transactionTypePick.delegate=self;
    transactionTypePick.dataSource = self;
    transactionTypePick.showsSelectionIndicator=YES;
    transactionTypeData=[[NSArray alloc]initWithObjects:@"买卖",@"赠与", nil];
    
    //赠与显示选中框
    giftRelationshipPick.delegate=self;
    giftRelationshipPick.dataSource = self;
    giftRelationshipPick.showsSelectionIndicator=YES;
    giftRelationshipData=[[NSArray alloc]initWithObjects:@"亲属关系",@"非亲属关系", nil];
    
    //房屋类型
    houseTypePick.delegate=self;
    houseTypePick.dataSource = self;
    houseTypePick.showsSelectionIndicator=YES;
    houseTypeData=[[NSArray alloc]initWithObjects:@"住房",@"非住房", nil];
   
    //买方住房记录类型
    buyerHistTypePick.delegate=self;
    buyerHistTypePick.dataSource = self;
    buyerHistTypePick.showsSelectionIndicator=YES;
    buyerHistTypeData=[[NSArray alloc]initWithObjects:@"家庭唯一住房",@"非家庭唯一住房", nil];
    
    //卖方住房类型
    sellerHouseTypePick.delegate=self;
    sellerHouseTypePick.dataSource = self;
    sellerHouseTypePick.showsSelectionIndicator=YES;
    sellerHouseTypeData=[[NSArray alloc]initWithObjects:@"普通住房",@"非普通住房", nil];
    
    //卖方购房年限类型
    sellerFixedYearsTypePick.delegate=self;
    sellerFixedYearsTypePick.dataSource = self;
    sellerFixedYearsTypePick.showsSelectionIndicator=YES;
    sellerFixedYearsTypeData=[[NSArray alloc]initWithObjects:@"不满两年",@"满两年不满五年",@"已满五年", nil];
    
    //卖方购房记录类型
    sellerHouseRecordTypePick.delegate=self;
    sellerHouseRecordTypePick.dataSource = self;
    sellerHouseRecordTypePick.showsSelectionIndicator=YES;
    sellerHouseRecordTypeData=[[NSArray alloc]initWithObjects:@"家庭唯一住房",@"非家庭唯一住房", nil];
    
    //个人所得税征收方式
    incomeTaxTypePick.delegate=self;
    incomeTaxTypePick.dataSource = self;
    incomeTaxTypePick.showsSelectionIndicator=YES;
    incomeTaxTypeData=[[NSArray alloc]initWithObjects:@"核定征收",@"据实征收", @"满五年家庭唯一住房免税",nil];
    
    //土地增值税征收方式
    landTaxTypePick.delegate=self;
    landTaxTypePick.dataSource = self;
    landTaxTypePick.showsSelectionIndicator=YES;
    landTaxTypeData=[[NSArray alloc]initWithObjects:@"核定征收",@"据实征收", @"个人住房免税",nil];
    
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
    NSLog(@"TAG=%d",pickerView.tag);
    
    if(pickerView.tag == 0){
        return [transactionTypeData count];
    }
    if(pickerView.tag == 1){
        return [giftRelationshipData count];
    }
    if(pickerView.tag == 2){
        return [houseTypeData count];
    }
    if(pickerView.tag == 3){
        return [buyerHistTypeData count];
    }
    if(pickerView.tag == 4){
        return [sellerHouseTypeData count];
    }
    if(pickerView.tag == 5){
        return [sellerFixedYearsTypeData count];
    }
    if(pickerView.tag == 6){
        return [sellerHouseRecordTypeData count];
    }
    if(pickerView.tag == 7){
        return [incomeTaxTypeData count];
    }
    if(pickerView.tag == 8){
        return [landTaxTypeData count];
    }
    NSInteger  currentRow=[pickerView selectedRowInComponent:component];
    return [pickArr[currentRow] count];
//
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger  currentRow=pickerView.tag;
   
    //NSInteger  currentRow=[pickerView selectedRowInComponent:0];
    return pickArr[currentRow][row];
//    return [transactionTypeData objectAtIndex:row];
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//
//{
//    
//    return 80.0;
//    
//}



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
    [lbl setBackgroundColor: [UIColor lightGrayColor]];
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
       
    return lbl;
}

//选择完成之后的事件:
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    [pickerView reloadComponent:1];
//    NSInteger areaRow=[pickerView selectedRowInComponent:0];
//    NSInteger teamRow=[pickerView selectedRowInComponent:1];
//   
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Picker Over

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
