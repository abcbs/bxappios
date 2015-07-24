//
//  LSProductMaintainViewController.m
//  KTAPP
//  商家商品信息维护
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductMaintainViewController.h"
#import "BusinessProduct.h"
#import "BSImagePickerController.h"


@interface LSProductMaintainViewController ()<BSImagePickerControllerDelegate,BSImagePlayerDelegate>

{
    BOOL isEdit;
    BOOL isHeaderImage;
    //商品头像图
    __block Resources *rs;
    //
    NSMutableArray *rsInfoArray;
    //
    NSMutableArray *rsImageArray;
}
@end

@implementation LSProductMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (rs==nil) {
        rs=[[Resources alloc]init];

    }
    if (rsImageArray==nil) {
         rsImageArray=[NSMutableArray array];
    }
   
    if (rsInfoArray==nil) {
        rsInfoArray=[NSMutableArray array];
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
        //商品轮播
        [self displayAD:_product.resourceImages];
        //
        [rsImageArray addObjectsFromArray: _product.resourceImages];
        [rsInfoArray addObjectsFromArray:_product.resourceInfoArray];
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
    //轮播图片资源，目前主要是类型和名称，其URL应当是服务端数据
    _product.resourceInfoArray=rsInfoArray;
    _product.resourceImages=rsImageArray;
    if (isEdit) {
        [_editDelegate sendEditedBusinessProduct:_product];
        _product = nil;
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
    BSImagePickerController *imagePickerController = [BSImagePickerController new];
    
    imagePickerController.mediaType = BSImagePickerMediaTypeImage;
    
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    imagePickerController.showsNumberOfSelectedAssets = NO;
    isHeaderImage=YES;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];


}
- (IBAction)previewProductHeadImage:(id)sender {
}

- (IBAction)chooseResourceImages:(id)sender {
    
    BSLog(@"商品维护，轮播图选择");
    BSImagePickerController *imagePickerController = [BSImagePickerController new];
    imagePickerController.mediaType = BSImagePickerMediaTypeImage;

    
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

#pragma mark - BSImagePickerControllerDelegate
//多选操作
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{

    if (isHeaderImage&&assets.count==1) {//点击为头图片选择
        PHAsset *headerImage=(PHAsset *)assets[0];
        rs.metatype=headerImage.mediaType;
        [self pickImageInfo:headerImage];

    }else{
        //轮播图片
        [self resourceImageView:assets];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)resourceImageView:(NSArray *)assets{
    //
    __block NSMutableArray *tempArray = [NSMutableArray array];
    __block int count=0;
    [rsInfoArray removeAllObjects];
    [rsImageArray removeAllObjects];
    for (PHAsset *headerImage in assets) {
        Resources *rss=[[Resources alloc]init];
        rss.metatype=headerImage.mediaType;
        [[PHImageManager defaultManager]
            requestImageDataForAsset:headerImage
            options:nil
            resultHandler:^(NSData *imageData, NSString *dataUTI,
                     UIImageOrientation orientation,
                     NSDictionary *info){
             UIImage *image=[[UIImage alloc]initWithData:imageData];
             [tempArray addObject:image];
             if ([info objectForKey:@"PHImageFileURLKey"]) {
               // path looks like this -
                 NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
                //数据类型
                 rss.name=[path path];
                 ++count;
                 [rsInfoArray addObject:rss];
                 [rsImageArray addObject:image];
                 if (assets.count==count) {//轮播图
                     [self displayAD:tempArray];
                 }
             }
         }];
    }
   
}

-(void)displayAD:(NSMutableArray *)images{
    BSFCRollingADImageUIView *adView= [BSFCRollingADImageUIView initADImageUIViewWith:images                                          playerDelegate:self
        target:self
        width:88 height:88];
    //资源轮播
    [adView removeFromSuperview];
    [_resourceImags addSubview:adView];
}

-(void)pickImageInfo:(PHAsset *)headerImage{

    [[PHImageManager defaultManager]
     requestImageDataForAsset:headerImage
     options:nil
     resultHandler:^(NSData *imageData, NSString *dataUTI,
                     UIImageOrientation orientation,
                     NSDictionary *info){
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

- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
   
}
@end
