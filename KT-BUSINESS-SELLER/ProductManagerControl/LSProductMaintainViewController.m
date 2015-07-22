//
//  LSProductMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductMaintainViewController.h"
#import "BusinessProduct.h"

@interface LSProductMaintainViewController ()
{
    BOOL isEdit;
}
@end

@implementation LSProductMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self modifiedStyle];
    
    [self initSubViews];
    
    [self setupEditProduct];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload{
    //删除数据
    [super viewDidUnload];
    

}

- (void)dealloc{
    
    
}

-(void)modifiedStyle{
    //CGSize size=_productName.size;
   // _productName.size=BSSizeMake(size.width,size.height);
    
}

- (void)initSubViews
{
    isEdit=NO;
}

- (void)setupEditProduct
{
    if (_editDelegate)
    {
         _productName.text = _product.name;
        _salePrice.text=[NSString stringWithFormat:@"%.2f", _product.salePrice];
        _preferPrice.text=[NSString stringWithFormat:@"%.2f",_product.preferPrice];
        isEdit = YES;
    }
}

- (IBAction)saveProductDate:(id)sender {
    //初始化化BusinessProduct
    _product=[[BusinessProduct alloc]init];
    _product.name=_productName.text;
    _product.introduce=_introduce.text;
    _product.salePrice=[_salePrice.text floatValue];
    _product.preferPrice=[_preferPrice.text floatValue];
    if (isEdit) {
        [_editDelegate sendEditedBusinessProduct:_product];
        _product = nil;
    }else{
       
    }
    if (!isEdit)
    {
        BusinessProduct *product = [self productOnSubViews];
        //把信息反馈给代理
        [_editDelegate sendAddBusinessProduct:product];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BusinessProduct *)productOnSubViews
{
    BusinessProduct *product = [[BusinessProduct alloc] init];
    product.name = _productName.text;
    
    return product;
}
@end
