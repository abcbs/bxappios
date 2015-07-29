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

@property(nonatomic,strong)     BSFCRollingADImageUIView *adView;
@end

@implementation LSProductDetailTableViewController
@synthesize adView=_adView;

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
    _publishTime.text=[Conf convertStringFromDate: _product.publishTime ];
    _introduce.text=_product.introduce;
    ProductBase *prdBase=_product.produceBase;
    _specification.text=prdBase.specification;
    //商品
    _comment.text=prdBase.comment;
    _saleStartTime.text=[Conf convertStringFromDate: _product.saleStartTime ];
    _saleOverTime.text=[Conf convertStringFromDate: _product.saleOverTime ];
    _introduce.text=_product.introduce;
    _headImage.image=_product.headerImage;
    [self displayAD:_product.resourceImages];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
}
-(void)displayAD:(NSMutableArray *)images{
    _adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:_resourceImags.height];
    //资源轮播
    if (_adView) {
        [_adView removeFromSuperview];
    }
    [_resourceImags addSubview:_adView];
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
