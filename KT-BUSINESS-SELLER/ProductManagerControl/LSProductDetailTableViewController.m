//
//  LSProductDetailTableViewController.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductDetailTableViewController.h"
#import "LSProductMaintainViewController.h"
#import "LBModelsHeader.h"

@interface LSProductDetailTableViewController ()

@end

@implementation LSProductDetailTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --样式调整

-(void)displayProduct{

    _productName.text=_product.name;


}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LSProductMaintainViewController *edit = (LSProductMaintainViewController *)segue.destinationViewController;
    edit.editDelegate = self;
    edit.product = _product;
}

-(void)sendEditedBusinessProduct:(BusinessProduct *)product{
    _product =product ;

    [_browseDelegate refreshBusinessProduct:product];
    [self displayProduct];

}

- (void)sendAddBusinessProduct:(BusinessProduct *) product{
    [_browseDelegate sendAddBusinessProduct:product];
    [self displayProduct];
}
@end
