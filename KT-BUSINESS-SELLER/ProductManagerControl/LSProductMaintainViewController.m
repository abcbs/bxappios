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
#import "BSIFTTHeader.h"

@interface LSProductMaintainViewController ()<BSPhotoTakeDelegate,BSImagePlayerDelegate>

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
    //图片选择与拍照
    self.takeController = [[BSPhotoTakeController alloc] init];
    self.takeController.delegate = self;
    
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
    
    [self clearViewData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -UITextView焦点操作
/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    //[self.tintColor]
    self.navigationItem.rightBarButtonItem = rightButton;
}

/** Finishes the editing */
- (void)dismissKeyboard
{
    [self saveData];
    [self.introduce resignFirstResponder];
    [self.comment resignFirstResponder];
    [self.specification resignFirstResponder];
    
}
#pragma mark --键盘关闭处理
#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -UITextView的代理事件，去除软键盘
-(void)modifiedStyle{
    //[self.publishTime setEnabled:YES];
    //[self.publishTime setHidden:YES];
    
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

/**
 *数据装载
 */
- (void)setupEditProduct
{
    if (_editDelegate)
    {
        _productName.text = _product.name;
        _salePrice.text=[NSString stringWithFormat:@"%.2f", _product.salePrice];
        _preferPrice.text=[NSString stringWithFormat:@"%.2f",_product.preferPrice];
        _publishTime.text=[Conf convertStringFromDate: _product.publishTime ];
        _introduce.text=_product.introduce;
        ProductBase *prdBase=_product.produceBase;
        _specification.text=prdBase.specification;
        //商品
        _comment.text=prdBase.comment;
        _saleStartTime.text=[Conf convertStringFromDate: _product.saleStartTime ];
        _saleOverTime.text=[Conf convertStringFromDate: _product.saleOverTime ];
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

/**
 *数据保存
 */
- (IBAction)saveProductDate:(id)sender {
    [self saveData];
}

-(void)saveData{
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
    //是否在售
    _product.isSale=_isSale.text;
    //是否促销
    _product.onSale=_onSale.text;
    
    //促销开始与结束时间
    //_product.saleStartTime=_saleStartTime.text;
    
    //_product.saleOverTime=_saleOverTime.text;
    //促销信息
    _product.introduce=_introduce.text;
    //商品介绍
    ProductBase *prdBase=[ProductBase new];
    //商品规格
    prdBase.specification=_specification.text;
    //商品介绍
    prdBase.comment=_comment.text;
    _product.produceBase=prdBase;
    
    //_product.
    if (isEdit) {
        [_editDelegate editedBusinessProduct:_product];
        _product = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (!isEdit)
    {
        if ([self.editDelegate
             respondsToSelector:@selector(addBusinessProduct:)]){
            BusinessProduct *product = [self productOnSubViews];
            //把信息反馈给代理
            [_editDelegate addBusinessProduct:product];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            BusinessManager *bm=[BusinessManager businessManager];
            [bm insertBusinessProduct:_product];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(nextData)];
            self.navigationItem.rightBarButtonItem = rightButton;
            
            UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"<商品列表" style:UIBarButtonItemStylePlain target:self action:@selector(toPageController)];
            self.navigationItem.leftBarButtonItem = leftButton;

        }
    }
    
    
    
}

-(void)toPageController{
    [self navigating:self storybord:@"LSProductManagerMain" identity:@"LSProductListTableViewController" canUseStoryboard:YES];
    
}
- (void)nextData
{
    [self.specification resignFirstResponder];
    [self.introduce resignFirstResponder];
    [self.comment resignFirstResponder];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightButton;
    _product=nil;
    _product=[BusinessProduct new];
    [self modifiedStyle];
    [self initSubViews];
    [self clearViewData];
}

-(void)clearViewData{
    //商家显示信息
    //商品名称
    _productName.text=nil;
    
    //销售价格
    _preferPrice.text=nil;
    
    //促销价格
    _salePrice.text=nil;
    
    //发布时间
    _publishTime.text=nil;
    
    //商品种类
    _productCatalogue.text=nil;
    
    //商品头像
    _headerImageView.image=nil;
    
    
    //商品介绍组图
    [_resourceImags removeConstraints:rsImageArray];
    
    
    //商品宣传，介绍
    _introduce.text=nil;
    
    //商品规格
    _specification.text=nil;
    
    //商品介绍，备注
    _comment.text=nil;
    
    //促销开始时间
    _saleStartTime.text=nil;
    
    //促销结束时间
    _saleOverTime.text=nil;
    
    //是否在售，上下架
    _isSale.text=nil;
    
    //是否促销
    _onSale.text=nil;
    
    //存量
    _numbers.text=nil;
    
    isEdit=NO;
    isHeaderImage=NO;
    rs=nil;
    //
    [rsInfoArray removeAllObjects];
    rsInfoArray=nil;
    //
    [rsImageArray removeAllObjects];
    rsImageArray=nil;
    
    _product.headerImage=nil;
    [_product.resourceIds removeAllObjects];
    [_product.resourceImages removeAllObjects];
    _product=nil;

    
}
- (BusinessProduct *)productOnSubViews
{
    BusinessProduct *product = [[BusinessProduct alloc] init];
    product.name = _productName.text;
    
    return product;
}


- (IBAction)chooseProductHeadImage:(id)sender {
    [self.takeController takeSinglePhotoOrChooseFromLibrary];
 
}
- (IBAction)previewProductHeadImage:(id)sender {
}

- (IBAction)chooseResourceImages:(id)sender {
     [self.takeController takeMultPhotoOrChooseFromLibrary];
}

- (IBAction)previewResourceImages:(id)sender {
}

#pragma mark - BSImagePickerControllerDelegate


-(void)displayAD:(NSMutableArray *)images{
    BSFCRollingADImageUIView *adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:(200)];
    //资源轮播
    [adView removeFromSuperview];
    [_resourceImags addSubview:adView];
}

- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    BSLog(@"取消拍照动作操作");
}

- (UIViewController *)takeController:(BSPhotoTakeController *)controller{
    return self;
}

- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(Resources *)info
{
    rs=info;
     [_headerImageView setImage:photo];
}
- (void)takeController:(BSPhotoTakeController *)controller gotPhotoArray:(NSMutableArray *)photoImages withInfo:(NSMutableArray *)info{
    [rsInfoArray removeAllObjects];
    [rsImageArray removeAllObjects];
    [rsInfoArray addObjectsFromArray:info];
    [rsImageArray addObjectsFromArray:photoImages];
    [self displayAD:photoImages];
    
}
- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
   
}
@end
