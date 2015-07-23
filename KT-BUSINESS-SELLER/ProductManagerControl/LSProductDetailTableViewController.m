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

@interface LSProductDetailTableViewController ()<BSImagePlayerDelegate>

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
    _salePrice.text=[NSString stringWithFormat:@"%.2f",_product.salePrice];
    _preferPrice.text=[NSString stringWithFormat:@"%.2f",_product.preferPrice];
    _publishTime.text=[Conf convertStringFromDate: _product.publishTime ];
    _headImage.image=_product.headerImage;
    [self displayAD:_product.resourceImages];

}

-(void)displayAD:(NSMutableArray *)images{
    BSFCRollingADImageUIView *adView= [BSFCRollingADImageUIView initADImageUIViewWith:images                                          playerDelegate:self
                                                                               target:self
                                                                                width:88 height:88];
    //资源轮播
    [adView removeFromSuperview];
    [_resourceImags addSubview:adView];
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
- (IBAction)previewHeadImage:(id)sender {
}

- (IBAction)previewResourceImages:(id)sender {
}

- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
    
}
@end
