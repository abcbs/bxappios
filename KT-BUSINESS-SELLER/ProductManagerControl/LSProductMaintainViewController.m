//
//  LSProductMaintainViewController.m
//  KTAPP
//  商家商品信息维护
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductMaintainViewController.h"
#import "BusinessProduct.h"
#import "QBImagePickerController.h"


@interface LSProductMaintainViewController ()<QBImagePickerControllerDelegate>

{
    BOOL isEdit;
    BOOL isHeaderImage;
    __block Resources *rs;
}
@end

@implementation LSProductMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (rs==nil) {
        rs=[[Resources alloc]init];

    }
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
    CGSize size=_productName.size;
    _productName.size=BSSizeMake(size.width,size.height);
    
}

- (void)initSubViews
{
    isEdit=NO;
    UIDatePicker *publishedTimePicker = [[UIDatePicker alloc] init];
    publishedTimePicker.datePickerMode = UIDatePickerModeDate;
    publishedTimePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    NSString *stdDate = DEFAULT_DATE;
    publishedTimePicker.date = [Conf convertDateFromString:stdDate];
    [publishedTimePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    _publishTime.inputView = publishedTimePicker;

}

- (void)chooseDate:(UIDatePicker *)datePicker
{
    NSDate *date = datePicker.date;
    NSString *dateString = [Conf convertStringFromDate:date];
    _publishTime.text = dateString;
}

- (void)setupEditProduct
{
    if (_editDelegate)
    {
        _productName.text = _product.name;
        _salePrice.text=[NSString stringWithFormat:@"%.2f", _product.salePrice];
        _preferPrice.text=[NSString stringWithFormat:@"%.2f",_product.preferPrice];
        _publishTime.text=[Conf convertStringFromDate: _product.publishTime ];

        //商品头像
        [_headerImageView setImage:_product.headerImage];
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
    //选择发布时间
    _product.publishTime=[Conf convertDateFromString:_publishTime.text];
    //头像图片
    _product.headerImage=_headerImageView.image;
    //头像资源数据
    _product.resourceInfo=rs;

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


- (IBAction)chooseProductHeadImage:(id)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;
    
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    //头像
    //imagePickerController.maximumNumberOfSelection = 1;
    //imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.showsNumberOfSelectedAssets = NO;
    isHeaderImage=YES;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];


}
- (IBAction)previewProductHeadImage:(id)sender {
}

- (IBAction)chooseResourceImages:(id)sender {
    
    BSLog(@"商品维护，轮播图选择");
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;

    
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    //最多9张，最少3张轮播介绍图片
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.minimumNumberOfSelection = 3;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];

}

- (IBAction)previewResourceImages:(id)sender {
}

#pragma mark - QBImagePickerControllerDelegate
//多选操作
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    BSLog(@"didFinishPickingAssets.");
    if (isHeaderImage) {//点击为头图片选择
        PHAsset *headerImage=(PHAsset *)assets[0];
        rs.metatype=headerImage.mediaType;
        [self pickImageInfo:headerImage];

    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)pickImageInfo:(PHAsset *)headerImage{

    [[PHImageManager defaultManager]
     requestImageDataForAsset:headerImage
     options:nil
     resultHandler:^(NSData *imageData, NSString *dataUTI,
                     UIImageOrientation orientation,
                     NSDictionary *info)
     {
         UIImage *image=[[UIImage alloc]initWithData:imageData];
         [_headerImageView setImage:image];
        
         NSLog(@"info = %@", info);
         if ([info objectForKey:@"PHImageFileURLKey"]) {
             // path looks like this -
             NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
             //数据类型
             rs.name=[path path];
        }
     }];
}
/*

 - (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
 {
 BSLog(@"Canceled.");
 
 [self dismissViewControllerAnimated:YES completion:NULL];
 }
 
- (BOOL)qb_imagePickerController:(QBImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset{
    BSLog(@"shouldSelectAsset.");
    return NO;
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset{
    BSLog(@"didDeselectAsset.");
}
*/
@end
