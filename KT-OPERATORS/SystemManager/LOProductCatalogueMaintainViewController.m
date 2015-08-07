//
//  LOProductCatalogueMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOProductCatalogueMaintainViewController.h"

@interface LOProductCatalogueMaintainViewController ()
<UITextFieldDelegate>
{
    BOOL isEdit;

}
@end


@implementation LOProductCatalogueMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initSubViews];
    
    [self setupData];
    
}

- (void)viewDidAppear:(BOOL)animated{

}


- (void)initSubViews
{
    isEdit=NO;
}

/**
 *数据装载
 */
- (void)setupData
{
    if (self.productCatalogue)
    {
        isEdit = YES;
        self.code.text=self.productCatalogue.code;
        self.comment.text=self.productCatalogue.comment;
        self.statusValue.text=self.productCatalogue.status;

    }
}

-(void)clearViewData{
    //经营范围说明
    self.comment.text=nil;
    self.code.text=nil;
    self.statusValue.text=nil;
}

-(BOOL) checkRightfulData{
    BOOL checkAnonName=[BSValidatePredicate
                        checkNilField:_code alert:@"业务类型代码名称不能为空"];
    if (!checkAnonName) {
        return NO;
    }
    
    return YES;
}

-(void)saveData{
    if (![self checkRightfulData]) {
        return;
    }
    self.productCatalogue.code=self.code.text;
    self.productCatalogue.comment=self.comment.text;
    self.productCatalogue.status=self.statusValue.text;

    //营业执照
    if (isEdit) {
        [self.editDelegate editedProductCatalogue:self.productCatalogue];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (!isEdit)
    {
        ProductCatalogue *bs=[ProductCatalogue new];
        bs.code=self.code.text;
        bs.comment=self.comment.text;
        bs.status=self.statusValue.text;
        [self.editDelegate addProductCatalogue:bs];
        
        //[self.navigationController popViewControllerAnimated:YES];
        //新建商家
        //ProductManager *bm=[ProductManager productManager];
        //[bm insertProductCatalogue:bs];
        [self clearViewData];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:
                                        
        self action:@selector(saveData)];
        self.navigationItem.rightBarButtonItem = rightButton;
            
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"<类型列表" style:UIBarButtonItemStylePlain target:self action:@selector(toPageController)];
            self.navigationItem.leftBarButtonItem = leftButton;
        
    }
    
}

-(void)toPageController{
    [self navigating:self storybord:@"LOCatagoryManager" identity:@"LOProductCatalogueListViewController"
            canUseStoryboard:YES];
    
}
- (void)nextData
{

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.productCatalogue=nil;
    self.productCatalogue=[ProductCatalogue new];
    [self modifiedStyle];
    [self initSubViews];
    [self clearViewData];
}

- (IBAction)saveBusinessData:(id)sender {
    [self saveData];
}

#pragma mark -UITextView焦点操作
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    //[self.tintColor]
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark --键盘关闭处理
#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];

    self.navigationItem.rightBarButtonItem = rightButton;
    return YES;
}

/** Finishes the editing */
- (void)dismissKeyboard
{
    [self saveData];
}

- (IBAction)status:(id)sender {

    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        self.statusValue.text= @"否";
    }else {
        self.statusValue.text= @"是";
    }
    
}

- (IBAction)saveProduceCatalogue:(id)sender {
    [self saveData];
}
@end
