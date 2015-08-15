//
//  ESSIssueViewController.m
//  KTAPP
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "ESSIssueViewController.h"
#import "BSIFTTHeader.h"
#import "TransferService.h"
#import "ESSEddystone.h"
#import "ESSBeaconIssue.h"

@interface ESSIssueViewController ()<ESSBeaconIssueDelegate, UITextViewDelegate>{
    ESSBeaconIssue *beaconIssue;
}


@property (strong, nonatomic) IBOutlet UITextView       *textView;

@property (strong, nonatomic) IBOutlet UISwitch         *advertisingSwitch;

@end

@implementation ESSIssueViewController


- (void)viewDidLoad {
    self.bDisplaySearchButtonNav=YES;
    self.bDisplayReturnButtonNav=YES;
    self.textView.delegate=self;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    beaconIssue = [[ESSBeaconIssue alloc] init];
    //设置代理
    beaconIssue.delegate = self;
    //开始扫描
    [beaconIssue  setupService];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [beaconIssue stopIssue];
    
    [super viewWillDisappear:animated];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    BSLog(@"Central subscribed to characteristic");
  
}

- (NSData *)sendingData:(ESSBeaconIssue *)issue{
    return [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
}
#pragma mark - TextView Methods

/** This is called when a change happens, so we know to stop advertising
 */
- (void)textViewDidChange:(UITextView *)textView
{
    // If we're already advertising, stop
    if (self.advertisingSwitch.on) {
        [self.advertisingSwitch setOn:NO];
        [beaconIssue stopIssue];
    }
    [textView resignFirstResponder];
}


/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


/** Finishes the editing */
- (void)dismissKeyboard
{
    [self.textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Switch Methods
/** Start advertising
 */
- (IBAction)switchChanged:(id)sender
{
    if (self.advertisingSwitch.on) {
        [ beaconIssue startIssue];
    }
    else {
        [beaconIssue stopIssue];
    }
}

@end
