//
//  BLEDevicesAddTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BLEDevicesAddTableViewController.h"

@interface  BLEDevicesAddTableViewController()<UITextViewDelegate >

@end

@implementation BLEDevicesAddTableViewController
@synthesize bleInfoDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bleName setTintColor:[UIColor redColor]];
    //文本编辑代理
    self.detailInfoTextField.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *头像选择
 */
- (IBAction)chooseHeaderImages:(id)sender {
    
}


//当开始点击textField会调用的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
//当textField编辑结束时调用的方法
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //[self.detailInfoTextField resignFirstResponder];

}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //[self.detailInfoTextField resignFirstResponder];
    
    return YES;
    
}
    
- (IBAction)saveBLEInfo:(id)sender {
    //从视图中获取数据
    //NSString *name=self.bleName.text;
    //CBPeripheral *discoveredPeripheral=[[CBPeripheral alloc]init];
    //discoveredPeripheral.name=name;
    //实例化BLE
    BLEInfo *bleInfo=[[BLEInfo alloc]init];
    //[bleInfo setDiscoveredPeripheral:discoveredPeripheral];
    
    //使用代理做数据处理
    [self.bleInfoDelegate addBLEInfo:bleInfo];
}

- (IBAction)pickImags:(id)sender {
}

- (IBAction)previewImages:(id)sender {
}


@end
